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
  }

  if (!length(problems)) {
    return(data.frame(severity = character(), message = character(),
                      stringsAsFactors = FALSE))
  }
  do.call(rbind, problems)
}
