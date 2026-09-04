# load_schema.R - read the register schema.
#
# Depends on base R + the `yaml` package. NOTHING ELSE. In particular it must
# never source anything from the guide: the guide reads the schema, never the
# other way round. That is what lets /schema/ move to its own repo unchanged.

if (!requireNamespace("yaml", quietly = TRUE)) {
  stop("The 'yaml' package is required: install.packages('yaml')")
}

# Root of the schema, i.e. the directory holding registers/ and code-systems/.
# Derived from this file's own location so it works from any working directory.
schema_root <- function() {
  this <- sub("--file=", "", grep("--file=", commandArgs(FALSE), value = TRUE)[1])
  if (!is.na(this) && nzchar(this)) {
    candidate <- normalizePath(file.path(dirname(this), ".."), mustWork = FALSE)
    if (dir.exists(file.path(candidate, "registers"))) return(candidate)
  }
  # Fall back to walking up from the working directory.
  d <- normalizePath(getwd(), mustWork = FALSE)
  repeat {
    if (dir.exists(file.path(d, "schema", "registers"))) return(file.path(d, "schema"))
    if (dir.exists(file.path(d, "registers"))) return(d)
    parent <- dirname(d)
    if (identical(parent, d)) stop("Could not locate the schema directory.")
    d <- parent
  }
}

read_yaml_dir <- function(dir) {
  files <- list.files(dir, pattern = "\\.ya?ml$", full.names = TRUE)
  out <- lapply(files, yaml::read_yaml)
  names(out) <- vapply(out, function(x) x$id %||% NA_character_, character(1))
  out
}

`%||%` <- function(a, b) if (is.null(a)) b else a

#' Load the whole schema into one list
load_schema <- function(root = schema_root()) {
  families <- if (dir.exists(file.path(root, "families"))) {
    read_yaml_dir(file.path(root, "families"))
  } else {
    list()
  }
  list(
    root = root,
    registers = read_yaml_dir(file.path(root, "registers")),
    families = families,
    code_systems = read_yaml_dir(file.path(root, "code-systems"))
  )
}

#' One register, with any family-level fields merged in
#'
#' Fields set on the register itself always win. Anything inherited from the
#' family is listed in the `inherited` attribute, so a caller can tell where a
#' fact came from.
get_register <- function(id, schema = load_schema()) {
  reg <- schema$registers[[id]]
  if (is.null(reg)) {
    stop("No such register: ", id, ". Known: ",
         paste(names(schema$registers), collapse = ", "))
  }
  fam_id <- reg$family
  if (is.null(fam_id) || is.na(fam_id)) return(reg)

  fam <- schema$families[[fam_id]]
  if (is.null(fam)) {
    warning("Register '", id, "' names family '", fam_id, "', which does not exist.")
    return(reg)
  }
  inheritable <- setdiff(names(fam), c("id", "name", "description", "registers"))
  taken <- character()
  for (f in inheritable) {
    if (is.null(reg[[f]])) {
      reg[[f]] <- fam[[f]]
      taken <- c(taken, f)
    }
  }
  attr(reg, "inherited") <- taken
  attr(reg, "family") <- fam_id
  reg
}

#' Columns of a register as a data frame, one row per column
get_columns <- function(id, schema = load_schema()) {
  cols <- get_register(id, schema)$columns
  if (!length(cols)) return(data.frame())
  flat <- function(x) {
    data.frame(
      id           = x$id %||% NA_character_,
      name         = x$name %||% NA_character_,
      label_da     = x$label$da %||% NA_character_,
      label_en     = x$label$en %||% NA_character_,
      type         = x$type %||% NA_character_,
      role         = x$role %||% NA_character_,
      code_system  = x$code_system %||% NA_character_,
      source_type  = x$provenance$source_type %||% NA_character_,
      verified_on  = as.character(x$provenance$verified_on %||% NA),
      reader_note  = x$reader_note %||% NA_character_,
      stringsAsFactors = FALSE
    )
  }
  do.call(rbind, lapply(cols, flat))
}

#' One code system
get_code_system <- function(id, schema = load_schema()) {
  cs <- schema$code_systems[[id]]
  if (is.null(cs)) {
    stop("No such code system: ", id, ". Known: ",
         paste(names(schema$code_systems), collapse = ", "))
  }
  cs
}

#' Every fact whose value set or provenance is unresolved
#'
#' This is what the local review list is checked against, so it cannot drift
#' away from the schema.
unresolved <- function(schema = load_schema()) {
  rows <- list()
  for (r in schema$registers) {
    for (cl in r$columns) {
      st <- cl$provenance$source_type %||% "unknown"
      if (st %in% c("unknown", "unverified")) {
        rows[[length(rows) + 1]] <- data.frame(
          kind = "column", register = r$id, item = cl$id,
          issue = paste0("provenance: ", st), stringsAsFactors = FALSE
        )
      }
      # A type assumed rather than taken from a source. Harmless on
      # the page, but the synthetic-data work generates values from it, so it
      # must not pass as verified.
      if (isTRUE(cl$provenance$type_inferred)) {
        rows[[length(rows) + 1]] <- data.frame(
          kind = "column", register = r$id, item = cl$id,
          issue = "type inferred from the column name, not sourced",
          stringsAsFactors = FALSE
        )
      }
    }
  }
  for (cs in schema$code_systems) {
    if (identical(cs$enumerated, FALSE)) {
      # Deliberately not enumerated: a large system that is linked out instead.
      # Not a gap, so not reported.
      next
    }
    if (identical(cs$lookup, "unknown") || is.null(cs$lookup)) {
      rows[[length(rows) + 1]] <- data.frame(
        kind = "code_system", register = NA_character_, item = cs$id,
        issue = "value set unknown", stringsAsFactors = FALSE
      )
    } else if (identical(cs$labels_complete, FALSE)) {
      # Values are confirmed but we do not know what they mean. Just as much a
      # gap as a missing value set, and easy to forget once the codes are there.
      rows[[length(rows) + 1]] <- data.frame(
        kind = "code_system", register = NA_character_, item = cs$id,
        issue = "values known, labels missing", stringsAsFactors = FALSE
      )
    }
  }

  # Columns that exist because of the tooling rather than the register. The
  # synthetic-data package needs to know which columns are not DST facts.
  for (r in schema$registers) {
    for (cl in r$columns) {
      if (identical(cl$origin, "tooling")) {
        rows[[length(rows) + 1]] <- data.frame(
          kind = "column", register = r$id, item = cl$id,
          issue = paste0("origin: tooling (", cl$added_by %||% "?", ")"),
          stringsAsFactors = FALSE
        )
      }
    }
  }
  if (!length(rows)) return(data.frame())
  do.call(rbind, rows)
}
