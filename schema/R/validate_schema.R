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
                          "server_verified", "guide_prose", "unknown")
ALLOWED_ORIGINS <- c("dst", "tooling")
ALLOWED_SCOPES <- c("dst", "project")

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

  for (r in schema$registers) {
    where <- paste0("register '", r$id %||% "?", "'")

    for (f in c("id", "name", "source_url", "columns")) {
      if (is.null(r[[f]])) add(where, ": missing required field `", f, "`")
    }
    if (!is.null(r$scope) && !r$scope %in% ALLOWED_SCOPES) {
      add(where, ": scope '", r$scope, "' is not one of ",
          paste(ALLOWED_SCOPES, collapse = "/"))
    }
    if (!is.null(r$family) && !is.na(r$family) && !r$family %in% fam_ids) {
      add(where, ": family '", r$family, "' has no file in families/")
    }
    if (!is.null(r$superseded_by) && !is.na(r$superseded_by) &&
        !r$superseded_by %in% reg_ids) {
      add(where, ": superseded_by '", r$superseded_by, "' is not a known register")
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
