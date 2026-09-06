# validate_schema.R - check that the schema is internally consistent.
#
# Base R + yaml only, like the loader, so it travels with /schema/ to whatever
# repo consumes it. It knows nothing about the guide.
#
#   source("schema/R/validate_schema.R")
#   validate_schema()          # returns a character vector of problems
#
# Exit status is the caller's business; this just reports.

ALLOWED_TYPES <- c("character", "factor", "date", "datetime", "integer", "numeric")
ALLOWED_ROLES <- c("join_key", "identifier", "date", "value", "code", "derived")
ALLOWED_SOURCE_TYPES <- c("dst_variable_list", "dst_documentation", "nomenclature",
                          "unverified", "unknown")
ALLOWED_ORIGINS <- c("dst", "tooling")
# "sds" is a register held by Sundhedsdatastyrelsen rather than DST. It reaches
# a project through Forskerservice, so the documentation, the naming and the
# ordering process are all different from a DST register's.
ALLOWED_SCOPES <- c("dst", "sds", "project")
# DST's own reference types, from its register overview: a snapshot on a date,
# a population fixed on a date with values accumulated over a period, rows with
# a start and an end, or one row per event.
ALLOWED_TIMING <- c("ultimo", "status", "status_period", "course", "event")
ALLOWED_CADENCE <- c("annual", "quarterly", "monthly", "continuous", "none")

# `one_row_per` is what ONE ROW IS, which is a different fact from how often the
# register is refreshed (`update_cadence`). BEF is refreshed quarterly and has
# one row per person per reference date; LMDB is refreshed annually and has one
# row per dispensed prescription. Generators need the first to decide how many
# rows to write and how they join; `unknown` is a legitimate value and better
# than a guess.
ALLOWED_GRAIN <- c("person", "person_reference_date", "event_from_person",
                   "expand_from_parent", "household_year", "unknown")

# Where a consumer gets the real codes for a system we deliberately do not list.
# "none" is a legitimate answer and is better than silence: it tells a generator
# to stop rather than to invent.
ALLOWED_VALUES_FROM <- c("csv", "package", "none")

# Coverage granularity: a whole year, a month, or a quarter. YAML parses an
# unquoted 1995-12 as a string, so all three arrive as character except a bare
# year, which arrives as an integer.
COVERAGE_PATTERN <- "^[0-9]{4}(-(0[1-9]|1[0-2])|-Q[1-4])?$"

check_coverage_value <- function(x) {
  if (is.null(x)) return(TRUE)
  grepl(COVERAGE_PATTERN, as.character(x)[1])
}

# Returns a data frame with `severity` ("error" or "warning") and `message`.
# Errors mean the schema is wrong. Warnings mean it is incomplete: a reference
# to a register that has not been written yet is normal while the schema is
# being built out, and it must be visible without blocking work.
validate_schema <- function(schema = load_schema()) {
  problems <- list()
  add <- function(..., severity = "error") {
    problems[[length(problems) + 1]] <<- data.frame(
      severity = severity, message = paste0(...), stringsAsFactors = FALSE
    )
  }

  check_coverage <- function(cv, where) {
    if (is.null(cv)) return(invisible(NULL))
    for (end in c("from", "to")) {
      if (!check_coverage_value(cv[[end]])) {
        add(where, ": coverage.", end, " is '", as.character(cv[[end]])[1],
            "', which is not YYYY, YYYY-MM or YYYY-Qn")
      }
    }
  }

  reg_ids <- names(schema$registers)
  cs_ids <- names(schema$code_systems)
  fam_ids <- names(schema$families)

  # A register with no id would be NA here and break every reference check.
  if (any(is.na(reg_ids))) add("A register file has no `id` field.")
  if (anyDuplicated(reg_ids)) {
    add("Duplicate register id: ", paste(unique(reg_ids[duplicated(reg_ids)]), collapse = ", "))
  }
  if (anyDuplicated(cs_ids)) {
    add("Duplicate code system id: ", paste(unique(cs_ids[duplicated(cs_ids)]), collapse = ", "))
  }

  # Validate the MERGED view, not the raw file. A fact inherited from a family
  # is still a fact the register asserts, and checking only the raw YAML let a
  # dangling family-level superseded_by through unnoticed.
  for (rid in reg_ids) {
    if (is.na(rid)) next
    r <- tryCatch(get_register(rid, schema), error = function(e) schema$registers[[rid]])
    where <- paste0("register '", r$id %||% "?", "'")

    for (f in c("id", "name", "source_url", "columns")) {
      if (is.null(r[[f]])) add(where, ": missing required field `", f, "`")
    }
    if (!is.null(r$reference_timing) && !r$reference_timing %in% ALLOWED_TIMING) {
      add(where, ": reference_timing '", r$reference_timing, "' is not one of ",
          paste(ALLOWED_TIMING, collapse = "/"))
    }
    if (!is.null(r$update_cadence) && !r$update_cadence %in% ALLOWED_CADENCE) {
      add(where, ": update_cadence '", r$update_cadence, "' is not one of ",
          paste(ALLOWED_CADENCE, collapse = "/"))
    }
    if (!is.null(r$scope) && !r$scope %in% ALLOWED_SCOPES) {
      add(where, ": scope '", r$scope, "' is not one of ",
          paste(ALLOWED_SCOPES, collapse = "/"))
    }
    if (!is.null(r$family) && !is.na(r$family) && !r$family %in% fam_ids) {
      add(where, ": family '", r$family, "' has no file in families/")
    }
    # A register can be replaced by several: DST split VNDS into three.
    for (sb in unlist(r$superseded_by)) {
      if (!is.na(sb) && !sb %in% reg_ids) {
        add(where, ": superseded_by '", sb,
            "', which has no file yet in registers/", severity = "warning")
      }
    }

    col_ids <- vapply(r$columns, function(x) x$id %||% NA_character_, character(1))
    if (anyDuplicated(col_ids)) {
      add(where, ": duplicate column id: ",
          paste(unique(col_ids[duplicated(col_ids)]), collapse = ", "))
    }

    # A join key that is not among the columns is the failure that silently
    # produces an empty join, so it is checked explicitly.
    for (k in unlist(r$join_keys)) {
      if (!k %in% vapply(r$columns, function(x) x$name %||% "", character(1))) {
        add(where, ": join key `", k, "` is not one of its columns")
      }
    }

    # A label that is nothing but digits is an import error, not a label. DST's
    # order list is a spreadsheet: a variable with no description leaves an empty
    # cell, and a reader that counts cells by position instead of by reference
    # shifts the whole row, landing a date serial in the label. That happened on
    # 2026-09-02 and put "45657" on 54 columns.
    for (cl in r$columns) {
      for (lang in c("da", "en")) {
        lab <- cl$label[[lang]]
        if (!is.null(lab) && grepl("^[0-9.]+$", lab)) {
          add(where, ", column '", cl$id, "': label.", lang, " is '", lab,
              "', which is a number rather than a label - almost certainly a",
              " column shift when importing from a spreadsheet")
        }
      }
    }

    # The generated table shows key columns and folds the rest away. A register
    # with none would render as an empty table above a fold-out holding
    # everything, which looks broken rather than curated.
    if (length(r$columns) > 8 && !any(vapply(r$columns, function(x) isTRUE(x$key), logical(1)))) {
      add(where, ": has ", length(r$columns),
          " columns and none marked `key: true`, so its table would render empty",
          severity = "warning")
    }

    # Coverage is read by machines, not only printed. Three granularities are
    # allowed and nothing else: a whole year, a month, or a quarter. Anything
    # looser cannot be turned into a date range without guessing which end of
    # the period is meant.
    if (is.null(r$one_row_per)) {
      add(where, ": missing `one_row_per`. It is what one row IS, which decides",
          " how a generator writes rows and how they join")
    } else if (!r$one_row_per %in% ALLOWED_GRAIN) {
      add(where, ": one_row_per '", r$one_row_per, "' is not one of ",
          paste(ALLOWED_GRAIN, collapse = "/"))
    }

    check_coverage(r$coverage, where)
    for (cl in r$columns) {
      check_coverage(cl$coverage, paste0(where, ", column '", cl$id %||% "?", "'"))
    }

    for (rel in r$relationships) {
      if (is.null(rel$to)) {
        add(where, ": a relationship has no `to`")
      } else if (!rel$to %in% reg_ids) {
        # Not written yet, or a typo. We cannot tell the two apart, so this is a
        # warning that stays visible until the target register exists.
        add(where, ": relationship points at '", rel$to,
            "', which has no file yet in registers/", severity = "warning")
      }
      if (!is.null(rel$cardinality) &&
          !rel$cardinality %in% c("one_to_one", "one_to_many", "many_to_one")) {
        add(where, ": cardinality '", rel$cardinality, "' is not recognised")
      }
    }

    for (cl in r$columns) {
      cw <- paste0(where, ", column '", cl$id %||% "?", "'")
      for (f in c("id", "name", "type", "role")) {
        if (is.null(cl[[f]])) add(cw, ": missing required field `", f, "`")
      }
      if (!is.null(cl$type) && !cl$type %in% ALLOWED_TYPES) {
        add(cw, ": type '", cl$type, "' is not one of ",
            paste(ALLOWED_TYPES, collapse = "/"))
      }
      if (!is.null(cl$role) && !cl$role %in% ALLOWED_ROLES) {
        add(cw, ": role '", cl$role, "' is not one of ",
            paste(ALLOWED_ROLES, collapse = "/"))
      }
      if (!is.null(cl$origin) && !cl$origin %in% ALLOWED_ORIGINS) {
        add(cw, ": origin '", cl$origin, "' is not one of ",
            paste(ALLOWED_ORIGINS, collapse = "/"))
      }
      if (!is.null(cl$superseded_by)) {
        others <- vapply(r$columns, function(x) x$name %||% "", character(1))
        if (!cl$superseded_by %in% others) {
          add(cw, ": superseded_by '", cl$superseded_by,
              "' is not another column of this register", severity = "warning")
        }
      }
      if (!is.null(cl$code_system) && !cl$code_system %in% cs_ids) {
        add(cw, ": code_system '", cl$code_system, "' has no file in code-systems/")
      }
      st <- cl$provenance$source_type
      if (is.null(st)) {
        add(cw, ": no provenance.source_type - every fact must say where it came from")
      } else if (!st %in% ALLOWED_SOURCE_TYPES) {
        add(cw, ": source_type '", st, "' is not one of ",
            paste(ALLOWED_SOURCE_TYPES, collapse = "/"))
      }
      # `note` was removed on purpose: provenance is structured, free text drifts.
      if (!is.null(cl$note)) {
        add(cw, ": has a `note` field. Use `reader_note` for reader-facing ",
            "caveats; maintenance commentary belongs in provenance or git history.")
      }
    }
  }

  # Families carry facts too, so their own fields are checked.
  for (f in schema$families) {
    fw <- paste0("family '", f$id %||% "?", "'")
    if (is.null(f$id)) add("A family file has no `id` field.")
    if (!is.null(f$reference_timing) && !f$reference_timing %in% ALLOWED_TIMING) {
      add(fw, ": reference_timing '", f$reference_timing, "' is not recognised")
    }
    if (!is.null(f$update_cadence) && !f$update_cadence %in% ALLOWED_CADENCE) {
      add(fw, ": update_cadence '", f$update_cadence, "' is not recognised")
    }
    if (!any(vapply(schema$registers,
                    function(r) identical(r$family, f$id), logical(1)))) {
      add(fw, ": no register belongs to this family", severity = "warning")
    }
  }

  for (cs in schema$code_systems) {
    cw <- paste0("code system '", cs$id %||% "?", "'")
    for (f in c("id", "name", "source_url")) {
      if (is.null(cs[[f]])) add(cw, ": missing required field `", f, "`")
    }
    if (!is.null(cs$note)) {
      add(cw, ": has a `note` field. Use `reader_note`.")
    }
    # Either enumerate the values, or say explicitly that you are not going to.
    if (!identical(cs$enumerated, FALSE) &&
        (is.null(cs$lookup) || identical(cs$lookup, "unknown"))) {
      # Not an error: an unresolved value set is a known state, tracked by
      # unresolved(). Only flag the ambiguous case.
      if (is.null(cs$lookup) && is.null(cs$enumerated)) {
        add(cw, ": no `lookup` and no `enumerated: false`. Say which it is.")
      }
    }

    # A system with no values is a hole a generator falls into silently: it
    # draws meaningless noise instead of real codes and nothing errors. So say
    # where the real codes come from, even if the answer is "nowhere machine
    # readable".
    if (identical(cs$enumerated, FALSE) && is.null(cs$values_from)) {
      add(cw, ": `enumerated: false` but no `values_from`. Say where a consumer",
          " gets the real codes, or `kind: none` if there is no such place.")
    }
    if (!is.null(cs$values_from)) {
      k <- cs$values_from$kind
      if (is.null(k) || !k %in% ALLOWED_VALUES_FROM) {
        add(cw, ": values_from.kind '", k %||% "NULL", "' is not one of ",
            paste(ALLOWED_VALUES_FROM, collapse = "/"))
      } else if (identical(k, "csv") && is.null(cs$values_from$url)) {
        add(cw, ": values_from.kind is 'csv' but there is no `url`")
      } else if (identical(k, "package") && !length(cs$values_from$candidates)) {
        add(cw, ": values_from.kind is 'package' but there are no `candidates`")
      }
    }
  }

  if (!length(problems)) {
    return(data.frame(severity = character(), message = character(),
                      stringsAsFactors = FALSE))
  }
  do.call(rbind, problems)
}
