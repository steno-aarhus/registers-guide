#!/usr/bin/env Rscript

# build-search-index.R - harvest the guide into a searchable index.
#
# Writes assets/search-index.json: one entry per section, with the page title,
# the heading, the anchor to jump to, and the prose. The "Search the guide" page
# fetches it and filters in the browser, so there is no server and no runtime
# dependency on anything.
#
# It also embeds .config/search-synonyms.yaml, so a reader who types the Danish
# word, or the word for what they are trying to do rather than the word the
# register uses, still lands on the right section.
#
# Why generate rather than search the rendered site: the .qmd source is what we
# control, the anchors are predictable from the headings, and a static index can
# be committed and diffed like the register tables.

suppressWarnings(suppressMessages(library(yaml)))

# The same guide must give the same index on every machine. The guide contains
# non-English letters, and R only treats them as letters when it runs with
# UTF-8 text. Started without it (LC_ALL=C, common in automated jobs), R cut
# the text in the middle of a letter and built different anchors, so the file
# came out different. So switch R to UTF-8 here, and stop if that is impossible
# rather than write a wrong index. The two names are the ones Linux and macOS
# use.
if (!l10n_info()[["UTF-8"]]) {
  for (loc in c("C.UTF-8", "en_US.UTF-8")) {
    if (nzchar(suppressWarnings(Sys.setlocale("LC_CTYPE", loc)))) break
  }
  if (!l10n_info()[["UTF-8"]]) {
    stop("build-search-index.R needs a UTF-8 locale. Run it as: ",
         "LC_ALL=en_US.UTF-8 Rscript tools/build-search-index.R")
  }
}

ROOT <- normalizePath(file.path(dirname(sub("--file=", "",
  grep("--file=", commandArgs(FALSE), value = TRUE)[1])), ".."))
OUT <- Sys.getenv("SEARCH_INDEX_OUT", unset = file.path(ROOT, "assets"))

# Helpers ----------------------------------------------------------------------

`%||%` <- function(a, b) if (is.null(a) || length(a) == 0) b else a

json_string <- function(x) {
  if (is.null(x) || length(x) == 0 || is.na(x[1])) return('""')
  x <- gsub("\\\\", "\\\\\\\\", as.character(x[1]))
  x <- gsub('"', '\\\\"', x)
  x <- gsub("[\r\n\t]+", " ", x)
  x <- gsub(" +", " ", x)
  paste0('"', trimws(x), '"')
}

# Quarto gives every heading an id, and a search result links to that id. If the
# heading has an explicit {#id}, Quarto uses it. Otherwise pandoc builds the id
# from the heading text (its auto_identifiers rule):
#   1. drop formatting, raw HTML tags and link targets, keep the text
#   2. lowercase
#   3. drop every character that is not a letter, a digit, a space or one of
#      "_", "-" and "."
#   4. join the words that are left with single hyphens
#   5. drop everything before the first letter
# Step 3 comes before step 4, so "MFR - Medical" becomes "mfr---medical": the
# hyphen survives as a word of its own and gets a hyphen on each side.
# Underscores are kept, so `case_when(x)` becomes "case_whenx".
#
# Not handled: _emphasis_ written with underscores (no heading uses it; write
# *emphasis* instead), and a heading with no letters at all.
#
# tools/check-guide.R has its own heading_id() for the link check. It still
# drops underscores, so the two functions disagree on headings that have one.
# The proof that this one is right is the rendered site: every anchor in the
# index must exist as an id in the HTML that `quarto render` writes.
anchor_for <- function(heading) {
  # Attribute block at the end of the heading, e.g. {#step-1 .step-heading}.
  attrs <- regmatches(heading, regexpr("\\{[^}]*\\}\\s*$", heading))
  # Explicit id: take only the word after "#", not the classes next to it.
  if (length(attrs) && grepl("#", attrs, fixed = TRUE)) {
    return(sub(".*#([^ }]+).*", "\\1", attrs))
  }
  h <- sub("^#{1,6}\\s+", "", heading)
  h <- sub("\\{[^}]*\\}\\s*$", "", h)

  # Split on backticks: pieces 1, 3, 5 ... are prose, pieces 2, 4 ... are code.
  # Pandoc keeps code exactly as written but changes prose first, so the three
  # rules below must only touch the prose pieces.
  parts <- strsplit(h, "`", fixed = TRUE)[[1]]
  prose <- seq_along(parts) %% 2 == 1
  # Raw HTML tags such as <small> are dropped, the text between them stays.
  parts[prose] <- gsub("<[^>]+>", "", parts[prose])
  # A link keeps its text and loses its url.
  parts[prose] <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", parts[prose])
  # "--" and "..." are turned into a dash and an ellipsis character, and both
  # are punctuation, so they vanish in step 3 ("Kaplan--Meier" -> "kaplanmeier").
  parts[prose] <- gsub("--+|\\.\\.\\.", "", parts[prose])
  h <- paste(parts, collapse = "")

  h <- tolower(h)
  h <- gsub("[^[:alnum:] _.-]", "", h)
  h <- gsub("[[:space:]]+", "-", trimws(h))
  sub("^[^[:alpha:]]+", "", h)
}

# When two headings on a page get the same id, pandoc adds -1 to the second,
# -2 to the third and so on. Takes the ids of ALL headings on a page, in order.
number_repeats <- function(ids) {
  out <- ids
  for (k in seq_along(ids)) {
    seen_before <- sum(ids[seq_len(k - 1)] == ids[k])
    if (seen_before > 0) out[k] <- paste0(ids[k], "-", seen_before)
  }
  out
}

heading_text <- function(heading) {
  h <- sub("^#{2,3}\\s+", "", heading)
  h <- gsub("\\{[^}]*\\}", "", h)
  trimws(gsub("`|\\*+", "", h))
}

# The identifiers inside code blocks are exactly what people search for:
# "how do I set the fastreg path" is answered by a line of code, not by prose.
# Keeping the whole block would flood the snippets, so keep only the names.
CODE_STOP <- c("library", "function", "return", "true", "false", "null", "for",
  "if", "else", "the", "and", "not", "your", "this", "that", "with", "from",
  "value", "values", "data", "name", "names", "list", "vector", "character",
  "numeric", "integer", "date", "paste", "print", "cat", "head", "nrow", "ncol")

code_terms <- function(lines) {
  fence <- grepl("^\\s*```", lines)
  code <- lines[cumsum(fence) %% 2 == 1 & !fence]
  if (!length(code)) return("")
  tok <- unlist(regmatches(code, gregexpr("[A-Za-z][A-Za-z0-9_.]{2,}", code)))
  tok <- tolower(unique(tok))
  tok <- tok[!tok %in% CODE_STOP & nchar(tok) < 40]
  paste(utils::head(tok, 80), collapse = " ")
}

# Strip what a reader is not searching for: front matter, code, raw html blocks,
# and the div fences Quarto uses for callouts.
clean_prose <- function(lines) {
  fence <- grepl("^\\s*```", lines)
  lines <- lines[cumsum(fence) %% 2 == 0 & !fence]
  lines <- lines[!grepl("^\\s*:::", lines)]
  lines <- lines[!grepl("^\\s*<", lines)]
  lines <- gsub("\\{\\{< include [^>]*>\\}\\}", "", lines)
  lines <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", lines)  # keep link text, drop url
  lines <- gsub("`|\\*+|^\\s*[-*+]\\s+|^\\s*\\|.*$", " ", lines)
  trimws(lines)
}

# Harvest ----------------------------------------------------------------------

qmd <- list.files(ROOT, pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE)
# Index only the files Quarto renders as pages, otherwise a search result links
# to a page that does not exist on the site. Quarto skips every file and folder
# whose name starts with "_" (includes/_badges.qmd, _ignore/, _site/) or with
# "." (.quarto/), and it skips README.qmd, which is only built into README.md.
rel_path <- sub(paste0("^", ROOT, "/"), "", qmd)
not_a_page <- grepl("(^|/)[_.]", rel_path) | basename(rel_path) == "README.qmd"
qmd <- qmd[!not_a_page]

entries <- list()
# method = "radix" sorts the same way on every machine. A plain sort() follows
# the computer's language settings, and they disagree on where "-" goes, so
# extract-variables.qmd and extraction-step-by-step.qmd could swap places.
for (path in sort(qmd, method = "radix")) {
  rel <- sub(paste0("^", ROOT, "/"), "", path)
  lines <- readLines(path, warn = FALSE)

  # Page title from the front matter.
  title <- rel
  if (length(lines) > 2 && grepl("^---\\s*$", lines[1])) {
    close <- which(grepl("^---\\s*$", lines))[2]
    if (!is.na(close)) {
      fm <- try(yaml.load(paste(lines[2:(close - 1)], collapse = "\n")), silent = TRUE)
      if (!inherits(fm, "try-error") && !is.null(fm$title)) title <- fm$title
      lines <- lines[(close + 1):length(lines)]
    }
  }

  # Split on H2 and H3. Anything before the first heading belongs to the page.
  is_head <- grepl("^#{2,3} ", lines) & cumsum(grepl("^\\s*```", lines)) %% 2 == 0
  starts <- which(is_head)

  # Ids for every heading on the page (H1 to H6), because a repeated id is
  # numbered across all levels, not only the H2 and H3 that are indexed.
  in_code <- cumsum(grepl("^\\s*```", lines)) %% 2 == 1
  all_heads <- which(grepl("^#{1,6} ", lines) & !in_code)
  head_ids <- number_repeats(vapply(lines[all_heads], anchor_for, character(1)))

  # A heading inside a ::: {.panel-tabset} block becomes a tab label, and a tab
  # label has no id on the page. Find those headings, so their sections can
  # link to the nearest real heading above instead. A div opens with ":::"
  # plus a name and closes with a bare ":::", so the list of divs that are
  # open at a line tells whether that line sits inside a tabset.
  open_divs <- character()
  in_tabset <- logical(length(lines))
  for (k in seq_along(lines)) {
    if (!in_code[k] && grepl("^\\s*:::+\\s*$", lines[k])) {
      open_divs <- utils::head(open_divs, -1)   # closes the innermost div
    } else if (!in_code[k] && grepl("^\\s*:::", lines[k])) {
      open_divs <- c(open_divs, lines[k])       # opens a new div
    }
    in_tabset[k] <- any(grepl("panel-tabset", open_divs, fixed = TRUE))
  }
  real_heads <- all_heads[!in_tabset[all_heads]]

  # The id to link to for a section that starts at line_no: its own heading,
  # or for a tab the last real heading before it ("" if there is none).
  anchor_at <- function(line_no) {
    above <- real_heads[real_heads <= line_no]
    if (!length(above)) return("")
    head_ids[match(max(above), all_heads)]
  }
  bounds <- c(1, starts, length(lines) + 1)

  for (i in seq_len(length(bounds) - 1)) {
    from <- bounds[i]; to <- bounds[i + 1] - 1
    if (to < from) next
    block <- lines[from:to]
    head_line <- if (i == 1 && !is_head[from]) "" else block[1]
    body <- clean_prose(if (nzchar(head_line)) block[-1] else block)
    body <- paste(body[nzchar(body)], collapse = " ")
    ct <- code_terms(if (nzchar(head_line)) block[-1] else block)
    if (nchar(body) < 40 && nchar(ct) < 20) next

    entries[[length(entries) + 1]] <- list(
      page = rel,
      title = title,
      heading = if (nzchar(head_line)) heading_text(head_line) else "",
      anchor = if (nzchar(head_line)) anchor_at(from) else "",
      # Cut at a word boundary: a snippet ending in "sampl" reads as a typo,
      # and the spell checker flags it as one.
      text = if (nchar(body) <= 1200) body
             else sub("\\s+\\S*$", "", substr(body, 1, 1200)),
      code = code_terms(if (nzchar(head_line)) block[-1] else block)
    )
  }
}

# Synonyms ---------------------------------------------------------------------

syn_path <- file.path(ROOT, ".config", "search-synonyms.yaml")
syn <- if (file.exists(syn_path)) (yaml.load_file(syn_path)$groups %||% list()) else list()

# Write ------------------------------------------------------------------------

dir.create(OUT, showWarnings = FALSE, recursive = TRUE)

sections <- vapply(entries, function(e) paste0(
  "{", paste(c(
    paste0('"page":', json_string(e$page)),
    paste0('"title":', json_string(e$title)),
    paste0('"heading":', json_string(e$heading)),
    paste0('"anchor":', json_string(e$anchor)),
    paste0('"text":', json_string(e$text)),
    paste0('"code":', json_string(e$code))
  ), collapse = ","), "}"), character(1))

groups <- vapply(syn, function(g) paste0("[",
  paste(vapply(g, json_string, character(1)), collapse = ","), "]"), character(1))

writeLines(c(
  "{",
  '"sections": [', paste0(sections, collapse = ",\n"), "],",
  '"synonyms": [', paste0(groups, collapse = ",\n"), "]",
  "}"
), file.path(OUT, "search-index.json"))

cat("wrote", normalizePath(file.path(OUT, "search-index.json"), mustWork = FALSE),
    "(", length(entries), "sections,", length(syn), "synonym groups )\n")
