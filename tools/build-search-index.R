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

# Quarto builds an anchor from the heading text: lowercase, punctuation dropped,
# spaces to dashes. An explicit {#id} on the heading wins.
anchor_for <- function(heading) {
  m <- regmatches(heading, regexpr("\\{#([^}]+)\\}", heading))
  if (length(m)) return(sub("\\{#(.*)\\}", "\\1", m))
  h <- sub("^#{2,3}\\s+", "", heading)
  h <- gsub("\\{[^}]*\\}", "", h)
  h <- gsub("`|\\*|\\[|\\]|\\(|\\)", "", h)
  h <- tolower(trimws(h))
  h <- gsub("[^a-z0-9æøå ]+", "", h)
  gsub(" +", "-", trimws(h))
}

heading_text <- function(heading) {
  h <- sub("^#{2,3}\\s+", "", heading)
  h <- gsub("\\{[^}]*\\}", "", h)
  trimws(gsub("`|\\*+", "", h))
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
qmd <- qmd[!grepl("/_ignore/|/_site/|/\\.quarto/", qmd)]

entries <- list()
for (path in sort(qmd)) {
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
  bounds <- c(1, starts, length(lines) + 1)

  for (i in seq_len(length(bounds) - 1)) {
    from <- bounds[i]; to <- bounds[i + 1] - 1
    if (to < from) next
    block <- lines[from:to]
    head_line <- if (i == 1 && !is_head[from]) "" else block[1]
    body <- clean_prose(if (nzchar(head_line)) block[-1] else block)
    body <- paste(body[nzchar(body)], collapse = " ")
    if (nchar(body) < 40) next

    entries[[length(entries) + 1]] <- list(
      page = rel,
      title = title,
      heading = if (nzchar(head_line)) heading_text(head_line) else "",
      anchor = if (nzchar(head_line)) anchor_for(head_line) else "",
      # Cut at a word boundary: a snippet ending in "sampl" reads as a typo,
      # and the spell checker flags it as one.
      text = if (nchar(body) <= 1200) body
             else sub("\\s+\\S*$", "", substr(body, 1, 1200))
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
    paste0('"text":', json_string(e$text))
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
