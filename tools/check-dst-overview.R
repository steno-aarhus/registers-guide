#!/usr/bin/env Rscript

# check-dst-overview.R - check the schema against DST's own register overview.
#
# DST publishes one table listing every register they deliver, with its
# reference type, its first and last year, and whether it is still open. Those
# are the same three facts the schema asserts about each register, so they can
# be checked instead of trusted. This script fetches that table and prints every
# disagreement.
#
# The failure mode it guards against: these fields are copied by hand once and
# then never looked at again, so a wrong value is indistinguishable from a right
# one. Nothing in the build reads them, so nothing complains. The variable list
# pages make it worse, because each one is a single-year snapshot and reads like
# a coverage statement when it is only a documentation year.
#
# DST wins. A disagreement means the schema is wrong, unless the schema says in
# a comment why it deviates on purpose.
#
# Run with `just check-dst-overview`. Needs network.

source(file.path(dirname(sub("--file=", "",
  grep("--file=", commandArgs(FALSE), value = TRUE)[1])), "..", "schema", "R", "load_schema.R"))

URL <- "https://www.dst.dk/extranet/forskningvariabellister/Oversigt%20over%20registre.html"

# DST's four reference types, in the order the schema names them. The patterns
# avoid the Danish letters on purpose: the page is served as Latin-1 and the
# encoding survives none of the round trips reliably, while "Forl.b" does.
TIMING <- c("Statusperiode" = "status_period",  # must be tried before "Status"
            "Status"        = "status",
            "Forl.b"        = "course",
            "H.ndelse"      = "event")

# The schema names two registers after the tables a delivery contains; DST lists
# them under their own names. Anything else is looked up as its own id.
ALIAS <- c(t_psyk_adm = "PSYK_ADM", t_psyk_diag = "PSYK_DIAG")

# Fetch -----------------------------------------------------------------------

html <- tryCatch(
  paste(readLines(url(URL, encoding = "latin1"), warn = FALSE), collapse = " "),
  error = function(e) NULL
)

# A checker that passes when it could not check is worse than no checker, so a
# failed fetch is a failure, not a skip.
if (is.null(html) || !nzchar(html)) {
  cat("COULD NOT CHECK: DST's register overview did not load.\n",
      "  ", URL, "\n",
      "  This is not a pass. Run it again when you have network.\n", sep = "")
  quit(status = 1)
}

# Parse ------------------------------------------------------------------------

cells_of <- function(row) {
  m <- regmatches(row, gregexpr("<t[dh][^>]*>.*?</t[dh]>", row, ignore.case = TRUE))[[1]]
  v <- gsub("<[^>]+>", " ", m)
  v <- gsub("&nbsp;", " ", v, fixed = TRUE)
  v <- trimws(gsub("[[:space:]]+", " ", v))
  v[nzchar(v)]
}

rows <- regmatches(html, gregexpr("<tr[^>]*>.*?</tr>", html, ignore.case = TRUE))[[1]]

dst <- list()
for (row in rows) {
  cs <- cells_of(row)
  if (!length(cs)) next
  id <- cs[1]
  # A register row starts with the register name in capitals. Everything else on
  # the page (headings, notes) fails this and is skipped.
  if (!grepl("^[A-Z0-9_ÆØÅ]+$", id)) next

  timing <- NA_character_
  for (i in seq_along(TIMING)) {
    if (any(grepl(paste0("^", names(TIMING)[i], "$"), cs))) {
      timing <- TIMING[[i]]
      break
    }
  }
  years <- cs[grepl("^(19|20)[0-9]{2}$", cs)]
  dst[[id]] <- list(
    timing = timing,
    from   = if (length(years) >= 1) years[1] else NA_character_,
    to     = if (length(years) >= 2) years[2] else NA_character_,
    closed = any(cs == "Luk")
  )
}

if (!length(dst)) {
  cat("COULD NOT CHECK: the overview loaded but no register rows were found.\n",
      "  DST may have changed the page layout, which this script cannot parse.\n", sep = "")
  quit(status = 1)
}

# Compare ----------------------------------------------------------------------

schema <- load_schema()
problems <- character()
note <- function(...) problems <<- c(problems, paste0(...))

checked <- 0
skipped <- character()

for (rid in names(schema$registers)) {
  r <- get_register(rid, schema)

  # Only DST's own registers are on this page. The SDS ones reach a project
  # through Forskerservice and are documented on esundhed instead.
  if (!identical(r$scope, "dst")) {
    skipped <- c(skipped, rid)
    next
  }

  key <- if (rid %in% names(ALIAS)) ALIAS[[rid]] else toupper(rid)
  d <- dst[[key]]
  if (is.null(d)) {
    note(rid, ": not found on DST's overview as '", key, "'. ",
         "Either the name changed or the register is no longer delivered.")
    next
  }
  checked <- checked + 1

  # Coverage is compared on the year alone. The schema may carry a month or a
  # quarter (BEF is 1985-12), which is finer than the overview and not drift.
  yr <- function(x) if (is.null(x)) NA_character_ else sub("-.*$", "", as.character(x))
  if (!identical(yr(r$coverage$from), d$from)) {
    note(rid, ": coverage.from is ", yr(r$coverage$from), ", DST says ", d$from)
  }
  if (!identical(yr(r$coverage$to), d$to)) {
    note(rid, ": coverage.to is ", yr(r$coverage$to), ", DST says ", d$to)
  }

  if (!is.na(d$timing) && !identical(r$reference_timing, d$timing)) {
    note(rid, ": reference_timing is ", r$reference_timing %||% "missing",
         ", DST says ", d$timing)
  }

  # DST marks a register that is no longer delivered as "Luk".
  if (!identical(isTRUE(r$deprecated), d$closed)) {
    note(rid, ": deprecated is ", isTRUE(r$deprecated),
         ", DST marks it ", if (d$closed) "Luk (closed)" else "open")
  }
}

# Report -----------------------------------------------------------------------

cat("Checked ", checked, " DST registers against the overview.\n", sep = "")
if (length(skipped)) {
  cat("Not on this page (scope is not dst): ", paste(skipped, collapse = ", "),
      "\n", sep = "")
}

if (!length(problems)) {
  cat("No drift.\n")
  quit(status = 0)
}

cat("\n", length(problems), " disagreement(s) with DST:\n\n", sep = "")
cat(paste0("  - ", problems, collapse = "\n"), "\n\n")
cat("DST wins. Fix the schema, or record in the file why it deviates.\n")
quit(status = 1)
