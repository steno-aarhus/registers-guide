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
  cols$Years <- years

  # Drop the Years column from a table whose own rows are all blank. Otherwise a
  # register with one odd column gives every table an empty Years column.
  drop_empty_years <- function(d) if (all(!nzchar(d$Years))) d[setdiff(names(d), "Years")] else d

  # A full register is too long to read: LPR_A_KONTAKT alone has 53 columns. The
  # schema marks the handful a researcher actually reaches for with `key: true`,
  # and the rest fold away. Marking is editorial, so it lives in the YAML rather
  # than being guessed here.
  is_key <- vapply(reg$columns, function(x) isTRUE(x$key), logical(1))
  if (any(is_key) && !all(is_key)) {
    out <- c(out, md_table(drop_empty_years(cols[is_key, , drop = FALSE])), "",
             "<details>",
             paste0("<summary>All other columns (", sum(!is_key), ")</summary>"),
             "", md_table(drop_empty_years(cols[!is_key, , drop = FALSE])), "")
    # Caveats on the folded columns belong with them, not on the main page.
    rest_notes <- Filter(Negate(is.null), lapply(reg$columns[!is_key], function(x) {
      if (is.null(x$reader_note)) return(NULL)
      paste0("- **`", x$name, "`:** ", gsub("\\s+", " ", x$reader_note))
    }))
    if (length(rest_notes)) out <- c(out, unlist(rest_notes), "")
    out <- c(out, "</details>", "")
  } else {
    out <- c(out, md_table(drop_empty_years(cols)), "")
  }

  # Where DST publishes no labels, the English ones here are readings of the
  # column names. A reader cannot tell that from the table, so say it.
  unlabelled <- sum(vapply(reg$columns, function(x)
    grepl("gives no label", x$provenance$verified_against %||% "", fixed = TRUE), logical(1)))
  if (unlabelled > 0) {
    out <- c(out, paste0(
      "*DST publishes no labels for ", unlabelled, " of these columns. ",
      "Where the Label column is filled in anyway, it is this guide's reading of ",
      "the column name, not an official description.*"), "")
  }

  inferred <- sum(vapply(reg$columns,
    function(x) isTRUE(x$provenance$type_inferred), logical(1)))
  if (inferred > 0) {
    out <- c(out, paste0(
      "*The Type column is read off the column name for ", inferred, " of these ",
      nrow(cols), " columns: no published source gives a data type for them. ",
      "Check with `sapply(class)` on a row of your own data before relying on it, ",
      "especially for code columns, which lose their leading zeros if they arrive ",
      "as numbers.*"), "")
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

    # Where the values came from. An enumerated set lists its codes rather than
    # linking out, so without this the reader has no way back to the source.
    # Both links: the document itself, and the page it is published on.
    cs_src <- Filter(Negate(is.null), lapply(unlist(used), function(cid) {
      cs <- schema$code_systems[[cid]]
      if (is.null(cs$source_url)) return(NULL)
      nm <- cs$source_name %||% "source"
      line <- paste0("- **`", cid, "`:** [", nm, "](", cs$source_url, ")")
      if (!is.null(cs$source_page))
        line <- paste0(line, ", published on [", sub("^https?://([^/]+).*$", "\\1", cs$source_page),
                       "](", cs$source_page, ")")
      # The CSV is the exact list, machine-readable, no scraping needed.
      if (!is.null(cs$source_csv))
        line <- paste0(line, " ([the code list as CSV](", cs$source_csv, "))")
      paste0(line, ".")
    }))
    if (length(cs_src)) out <- c(out, "Where these values come from:", "", unlist(cs_src), "")
    out <- c(out, "</details>", "")
  }

  # 4. reader_note, NOT note. `note` is maintenance commentary for whoever
  # edits the schema (where a value came from, what the guide used to say);
  # `reader_note` is the caveat a researcher needs while reading the table.
  # Rendering both put provenance chatter on the page.
  derived <- Filter(function(x) !is.null(x$derivation), reg$columns)
  if (length(derived)) {
    lines <- unlist(lapply(derived, function(x) {
      d <- gsub("\\s+", " ", x$derivation)
      # A long formula in inline code cannot wrap, so it runs off the page and
      # under the sidebar. Give it a fenced block, which scrolls on its own.
      if (nchar(d) > 70) c(paste0("**`", x$name, "`**"), "", "```", d, "```")
      # The source may state the formula with the variable name already in it.
      else if (grepl("=", d, fixed = TRUE)) paste0("- `", d, "`")
      else paste0("- **`", x$name, "`** = ", d)
    }))
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

# The overview table -----------------------------------------------------------
#
# It used to be maintained by hand, and drifted: it still said LPR3 started in
# March 2019 after the schema had been corrected to 2017, and gave LMDB as
# "approx. 1994+" against DST's 1995Q2. Same facts, one source.

build_overview <- function(schema = load_schema()) {
  ids <- sort(names(schema$registers))
  rows <- lapply(ids, function(id) {
    r <- get_register(id, schema)
    per <- {
      f <- as.character(r$coverage$from %||% ""); t <- as.character(r$coverage$to %||% "")
      if (!nzchar(f) && !nzchar(t)) "*not recorded*" else paste0(f, " to ", t)
    }
    keys <- vapply(Filter(function(x) isTRUE(x$key), r$columns), function(x) x$name, character(1))
    keys <- setdiff(keys, unlist(r$join_keys))
    nm <- if (!is.null(r$source_url)) paste0("[", toupper(id), "](", r$source_url, ")") else toupper(id)
    data.frame(
      Register = nm,
      `Read as` = paste0("`\"", id, "\"`"),
      `Join key` = paste0("`", paste(unlist(r$join_keys), collapse = "`, `"), "`"),
      Period = per,
      `Often used` = if (length(keys)) paste0("`", paste(head(keys, 3), collapse = "`, `"), "`") else "",
      check.names = FALSE, stringsAsFactors = FALSE
    )
  })
  out <- c(
    "<!-- Generated from schema/registers/ by tools/build-schema-tables.R. Do not edit by hand. -->",
    "", md_table(do.call(rbind, rows)))
  path <- file.path(OUT, "register-overview.md")
  writeLines(out, path)
  cat("wrote", normalizePath(path, mustWork = FALSE), "\n")
}

# The variable index ------------------------------------------------------------
#
# Every column in every register as one JSON array, for the "Find a variable"
# page. Written from the same schema as the tables, so it cannot drift from them.
# No dependency beyond base R: the strings are escaped by hand rather than
# pulling in a JSON package the loader does not otherwise need.

json_string <- function(x) {
  if (is.null(x) || length(x) == 0 || is.na(x[1])) return("null")
  x <- gsub("\\\\", "\\\\\\\\", as.character(x[1]))
  x <- gsub('"', '\\\\"', x)
  x <- gsub("[\r\n\t]+", " ", x)
  paste0('"', x, '"')
}

build_variable_index <- function(schema = load_schema()) {
  rows <- character()
  for (id in sort(names(schema$registers))) {
    r <- get_register(id, schema)
    for (cl in r$columns) {
      cov <- {
        f <- as.character(cl$coverage$from %||% ""); t <- as.character(cl$coverage$to %||% "")
        if (!nzchar(f) && !nzchar(t)) "null" else json_string(paste0(f, " to ", t))
      }
      rows <- c(rows, paste0(
        "{", paste(c(
          paste0('"name":', json_string(cl$name)),
          paste0('"register":', json_string(id)),
          paste0('"register_name":', json_string(r$name)),
          paste0('"label":', json_string(cl$label$en %||% cl$label$da)),
          paste0('"type":', json_string(cl$type)),
          paste0('"role":', json_string(cl$role)),
          paste0('"key":', if (isTRUE(cl$key)) "true" else "false"),
          paste0('"type_inferred":', if (isTRUE(cl$provenance$type_inferred)) "true" else "false"),
          paste0('"coverage":', cov),
          paste0('"code_system":', json_string(cl$code_system)),
          paste0('"note":', json_string(if (is.null(cl$reader_note)) NULL
                                        else gsub("\\s+", " ", cl$reader_note))),
          paste0('"derivation":', json_string(if (is.null(cl$derivation)) NULL
                                              else gsub("\\s+", " ", cl$derivation))),
          paste0('"derivation_source":', json_string(cl$derivation_source)),
          paste0('"superseded_by":',
                 if (is.null(cl$superseded_by)) "null"
                 else json_string(paste(unlist(cl$superseded_by), collapse = ", "))),
          paste0('"origin":', json_string(
            if (identical(cl$origin, "tooling"))
              paste0("not a DST variable - added by ", cl$added_by %||% "the conversion")
            else NULL)),
          paste0('"guide_page":', json_string(cl$provenance$guide_page)),
          # Where this column's facts come from, so a reader can judge them
          # rather than take them on faith.
          paste0('"src_type":', json_string(cl$provenance$source_type)),
          paste0('"src_url":', json_string(cl$provenance$source_url)),
          paste0('"type_source":', json_string(
            if (is.null(cl$provenance$type_source)) NULL
            else gsub("\\s+", " ", cl$provenance$type_source))),
          paste0('"source_url":', json_string(r$source_url))
        ), collapse = ","), "}"))
    }
  }
  # assets/, not _generated/: Quarto does not copy anything under a directory
  # starting with an underscore, and this file is fetched by the browser at
  # runtime rather than included at render time.
  dir <- file.path(dirname(OUT), "assets")
  dir.create(dir, showWarnings = FALSE, recursive = TRUE)
  # The value sets travel with the index. Finding out what code 5100 means is
  # the slow part of register work, and the schema already knows: without this
  # the search shows the name of the code system and leaves the reader to go
  # looking. Shipped once as a lookup rather than repeated on every column.
  cs_rows <- character()
  for (cid in sort(names(schema$code_systems))) {
    cs <- schema$code_systems[[cid]]
    vals <- "null"
    if (!is.null(cs$lookup) && !identical(cs$lookup, "unknown") && length(cs$lookup)) {
      vv <- vapply(names(cs$lookup), function(k) {
        lab <- cs$lookup[[k]]
        en <- lab$en %||% lab$da %||% ""
        da <- lab$da %||% ""
        paste0("{", paste(c(paste0('"code":', json_string(k)),
                            paste0('"en":', json_string(en)),
                            paste0('"da":', json_string(da))), collapse = ","), "}")
      }, character(1))
      vals <- paste0("[", paste(vv, collapse = ","), "]")
    }
    cs_rows <- c(cs_rows, paste0(json_string(cid), ":{", paste(c(
      paste0('"name":', json_string(cs$name)),
      paste0('"description":', json_string(gsub("\\s+", " ", cs$description %||% ""))),
      paste0('"note":', json_string(gsub("\\s+", " ", cs$reader_note %||% ""))),
      paste0('"source_url":', json_string(cs$source_url)),
      paste0('"source_page":', json_string(cs$source_page)),
      paste0('"source_csv":', json_string(cs$source_csv)),
      paste0('"source_name":', json_string(cs$source_name %||% "source")),
      paste0('"values":', vals)
    ), collapse = ","), "}"))
  }

  # Register-level facts a searcher needs the moment they find a column: how to
  # join it, whether the register is closed, and what it is. Shipped once.
  reg_rows <- character()
  for (rid in sort(names(schema$registers))) {
    r <- get_register(rid, schema)
    reg_rows <- c(reg_rows, paste0(json_string(rid), ":{", paste(c(
      paste0('"name":', json_string(r$name)),
      paste0('"description":', json_string(gsub("\\s+", " ", r$description %||% ""))),
      paste0('"join_keys":', json_string(paste(unlist(r$join_keys), collapse = ", "))),
      paste0('"coverage":', json_string(paste0(r$coverage$from %||% "?", " to ", r$coverage$to %||% "?"))),
      paste0('"timing":', json_string(gsub("_", " ", r$reference_timing %||% ""))),
      paste0('"scope":', json_string(r$scope)),
      paste0('"deprecated":', if (isTRUE(r$deprecated)) "true" else "false"),
      paste0('"superseded_by":', json_string(paste(unlist(r$superseded_by), collapse = ", "))),
      paste0('"overlap_note":', json_string(if (is.null(r$overlap_note)) NULL
                                            else gsub("\\s+", " ", r$overlap_note))),
      paste0('"cadence":', json_string(r$update_cadence)),
      paste0('"joins":', if (!length(r$relationships)) "null" else json_string(
        paste(vapply(r$relationships, function(x)
          paste0(x$key, " to ", toupper(x$to),
                 if (!is.null(x$cardinality)) paste0(" (", gsub("_", "-", x$cardinality), ")") else ""),
          character(1)), collapse = "; "))),
      paste0('"source_url":', json_string(r$source_url))
    ), collapse = ","), "}"))
  }

  # Same synonym map as the guide search. Without it the two pages behave
  # differently: "indkomst" finds nothing here while "income" does, purely
  # because of which labels happened to get translated.
  syn_path <- file.path(schema_root(), "..", ".config", "search-synonyms.yaml")
  syn <- if (file.exists(syn_path)) (yaml::yaml.load_file(syn_path)$groups %||% list()) else list()
  syn_json <- vapply(syn, function(g) paste0("[",
    paste(vapply(g, json_string, character(1)), collapse = ","), "]"), character(1))

  path <- file.path(dir, "variables.json")
  writeLines(c('{"columns": [', paste0(rows, collapse = ",\n"), "],",
               '"code_systems": {', paste0(cs_rows, collapse = ",\n"), "},",
               '"registers": {', paste0(reg_rows, collapse = ",\n"), "},",
               '"synonyms": [', paste0(syn_json, collapse = ",\n"), "]}"), path)
  cat("wrote", normalizePath(path, mustWork = FALSE), "(", length(rows), "columns )\n")
}

schema <- load_schema()
for (id in names(schema$registers)) build_register(id, schema)
build_overview(schema)
build_variable_index(schema)
