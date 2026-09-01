#!/usr/bin/env Rscript

# build-schema-tables.R - render the guide's register tables from the schema.
#
# Reads /schema/ and writes markdown partials to _generated/, which the .qmd
# pages pull in with {{< include >}}. Run it with `just build-schema-tables`.
#
# Why generate offline instead of an executable chunk: the site build has no R
# at all (see .github/workflows/build-website.yml), and adding one means the
# site cannot publish if an R install fails. Generating here also puts the
# tables in git, so a change to a fact shows up as a reviewable diff BEFORE it
# reaches the live site.
#
# This file may read the schema. The schema must never read this file.

source(file.path(dirname(sub("--file=", "",
  grep("--file=", commandArgs(FALSE), value = TRUE)[1])), "..", "schema", "R", "load_schema.R"))

# Overridable so the drift check can render to a temp dir and compare.
OUT <- Sys.getenv("SCHEMA_TABLES_OUT",
                  unset = file.path(schema_root(), "..", "_generated"))
dir.create(OUT, showWarnings = FALSE, recursive = TRUE)

# Helpers ----------------------------------------------------------------------

md_table <- function(df, align = NULL) {
  if (!nrow(df)) return(character())
  head <- paste0("| ", paste(names(df), collapse = " | "), " |")
  rule <- paste0("| ", paste(rep("---", ncol(df)), collapse = " | "), " |")
  body <- apply(df, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |"))
  c(head, rule, body)
}

# A join key is what a reader looks for first, so mark it.
col_name <- function(x) {
  if (identical(x$role, "join_key")) paste0("**`", x$name, "`**") else paste0("`", x$name, "`")
}

code_values <- function(cs) {
  if (identical(cs$enumerated, FALSE)) {
    n <- if (!is.null(cs$description)) sub("^.*?(\\d+) .*$", "\\1", cs$description) else ""
    return(paste0("Not listed here - see [DST's classification](", cs$source_url, ")"))
  }
  lk <- cs$lookup
  if (is.null(lk) || identical(lk, "unknown")) return("*not yet sourced*")
  paste(vapply(names(lk), function(k) {
    lab <- lk[[k]]$da
    if (is.null(lab)) paste0("`", k, "`") else paste0("`", k, "` ", lab)
  }, character(1)), collapse = ", ")
}

# Build one register -----------------------------------------------------------

build_register <- function(id, schema = load_schema()) {
  reg <- get_register(id, schema)
  out <- c(
    paste0("<!-- Generated from schema/registers/", id,
           ".yaml by tools/build-schema-tables.R. Do not edit by hand. -->"),
    ""
  )

  # 1. the columns
  cols <- data.frame(
    Column = vapply(reg$columns, col_name, character(1)),
    Type   = vapply(reg$columns, function(x) x$type %||% "", character(1)),
    Role   = vapply(reg$columns, function(x) gsub("_", " ", x$role %||% ""), character(1)),
    Label  = vapply(reg$columns, function(x) x$label$en %||% x$label$da %||% "", character(1)),
    stringsAsFactors = FALSE
  )
  # A column can start or stop inside the register's own lifetime. Show the years
  # only when they differ from the register's, so the column stays empty for the
  # ordinary case and a value in it always means "read this".
  reg_from <- as.character(reg$coverage$from %||% "")
  reg_to   <- as.character(reg$coverage$to %||% "")
  years <- vapply(reg$columns, function(x) {
    from <- as.character(x$coverage$from %||% "")
    to   <- as.character(x$coverage$to %||% "")
    if (!nzchar(from) && !nzchar(to)) return("")
    if (from == reg_from && to == reg_to) return("")
    # " to ", not a dash: the values are themselves dashed (1985-12, 2004-Q2)
    if (!nzchar(to)) paste0("from ", from)
    else if (!nzchar(from)) paste0("until ", to)
    else paste0(from, " to ", to)
  }, character(1))
  if (any(nzchar(years))) cols$Years <- years

  # A full register is too long to read: LPR_A_KONTAKT alone has 53 columns. The
  # schema marks the handful a researcher actually reaches for with `key: true`,
  # and the rest fold away. Marking is editorial, so it lives in the YAML rather
  # than being guessed here.
  is_key <- vapply(reg$columns, function(x) isTRUE(x$key), logical(1))
  if (any(is_key) && !all(is_key)) {
    out <- c(out, md_table(cols[is_key, , drop = FALSE]), "",
             "<details>",
             paste0("<summary>All other columns (", sum(!is_key), ")</summary>"),
             "", md_table(cols[!is_key, , drop = FALSE]), "")
    # Caveats on the folded columns belong with them, not on the main page.
    rest_notes <- Filter(Negate(is.null), lapply(reg$columns[!is_key], function(x) {
      if (is.null(x$reader_note)) return(NULL)
      paste0("- **`", x$name, "`:** ", gsub("\\s+", " ", x$reader_note))
    }))
    if (length(rest_notes)) out <- c(out, unlist(rest_notes), "")
    out <- c(out, "</details>", "")
  } else {
    out <- c(out, md_table(cols), "")
  }

  # 2. joins - this is what "Household key - join to FAIK" used to say in a cell
  if (length(reg$join_keys)) {
    out <- c(out, paste0("**Join key:** ",
                         paste0("`", unlist(reg$join_keys), "`", collapse = ", "), "."), "")
  }
  if (length(reg$relationships)) {
    lines <- vapply(reg$relationships, function(r) {
      card <- gsub("_", "-", r$cardinality %||% "")
      paste0("- `", r$key, "` joins to **", toupper(r$to), "**",
             if (nzchar(card)) paste0(" (", card, ")") else "", ".")
    }, character(1))
    out <- c(out, "**Joins to other registers:**", "", lines, "")
  }

  # 3. code systems, folded away so the column table stays readable
  used <- unique(Filter(Negate(is.null), lapply(reg$columns, function(x) x$code_system)))
  if (length(used)) {
    tbl <- data.frame(
      `Code system` = paste0("`", unlist(used), "`"),
      Values = vapply(unlist(used), function(cid) code_values(schema$code_systems[[cid]]),
                      character(1)),
      check.names = FALSE, stringsAsFactors = FALSE
    )
    out <- c(out,
             "<details>",
             paste0("<summary>Value sets for the coded columns (", length(used), ")</summary>"),
             "", md_table(tbl), "")
    # A code system can carry a caveat a reader needs: which period a code set
    # is valid for, or a neighbouring system it is easily confused with.
    cs_notes <- Filter(Negate(is.null),
                       lapply(unlist(used), function(cid) {
                         cs <- schema$code_systems[[cid]]
                         if (is.null(cs$reader_note)) return(NULL)
                         paste0("- **`", cid, "`:** ", gsub("\\s+", " ", cs$reader_note))
                       }))
    if (length(cs_notes)) out <- c(out, unlist(cs_notes), "")
    out <- c(out, "</details>", "")
  }

  # 4. reader_note, NOT note. `note` is maintenance commentary for whoever
  # edits the schema (where a value came from, what the guide used to say);
  # `reader_note` is the caveat a researcher needs while reading the table.
  # Rendering both put provenance chatter on the page.
  derived <- Filter(function(x) !is.null(x$derivation), reg$columns)
  if (length(derived)) {
    lines <- vapply(derived, function(x) {
      d <- gsub("\\s+", " ", x$derivation)
      # The source may state the formula with the variable name already in it.
      if (grepl("=", d, fixed = TRUE)) paste0("- `", d, "`")
      else paste0("- **`", x$name, "`** = ", d)
    }, character(1))
    out <- c(out, "**How it is computed:**", "", lines, "")
  }

  # Only the key columns: the folded ones already carry their notes inside the
  # <details> block, and repeating them here would undo the folding.
  shown <- if (any(is_key) && !all(is_key)) reg$columns[is_key] else reg$columns
  noted <- Filter(function(x) !is.null(x$reader_note), shown)
  if (length(noted)) {
    lines <- vapply(noted, function(x) {
      paste0("- **`", x$name, "`:** ", gsub("\\s+", " ", x$reader_note))
    }, character(1))
    out <- c(out, "**Worth knowing:**", "", lines, "")
  }

  # Drop trailing blank lines. end-of-file-fixer strips them on commit, so
  # emitting them here would put the generator and the hook in permanent
  # disagreement and the drift check would never pass.
  while (length(out) && !nzchar(out[length(out)])) out <- out[-length(out)]

  path <- file.path(OUT, paste0(id, "-columns.md"))
  writeLines(out, path)
  cat("wrote", normalizePath(path, mustWork = FALSE), "\n")
}

schema <- load_schema()
for (id in names(schema$registers)) build_register(id, schema)
