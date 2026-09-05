#!/usr/bin/env Rscript

# check-guide.R - weekly check of the guide
#
# Runs four checks that the Quarto build does NOT catch:
#
#   code      Can every ```r block even be parsed as R?
#   functions Do the functions we call actually exist?
#   links     Do internal .qmd links and anchors point at something real?
#   style     Do we follow the house rules (no em dash, %>% not |>, colon
#             after labels)?
#
# Usage:  Rscript tools/check-guide.R [all|code|functions|style|links|schema]
#         just check-guide
#
# Base R only, nothing to install.
#
# Exceptions:
#   - A code block that is deliberately not valid R (pseudocode) is marked
#     ```{.r .no-check}. It keeps R syntax highlighting but is skipped here.
#   - Function names the check cannot look up can be added to
#     .config/known-functions.txt (one name per line).

ROOT <- normalizePath(file.path(dirname(sub("--file=", "", grep("--file=", commandArgs(FALSE), value = TRUE)[1])), ".."))
if (is.na(ROOT) || !dir.exists(ROOT)) ROOT <- getwd()

# Errors and warnings collect here and are printed at the end.
FINDINGS <- new.env(parent = emptyenv())
FINDINGS$errors <- character()
FINDINGS$warnings <- character()

fail <- function(...) FINDINGS$errors <- c(FINDINGS$errors, paste0(...))
warn <- function(...) FINDINGS$warnings <- c(FINDINGS$warnings, paste0(...))

header <- function(txt) cat("\n", txt, "\n", strrep("-", nchar(txt)), "\n", sep = "")

qmd_files <- function() {
  # Every page sits in the root, including the darter-* ones. README and 404
  # are not guide content and are not checked.
  files <- list.files(ROOT, pattern = "\\.qmd$", full.names = TRUE)
  files[!basename(files) %in% c("README.qmd", "404.qmd")]
}

rel <- function(path) sub(paste0("^", ROOT, "/"), "", path)

# Shared: pull code blocks out of a .qmd file ----------------------------------
# Returns a list of blocks: info (the fence text), code (the lines), start (the
# line number of the fence). Handles fences with 3 or more backticks, so a
# ```` block that SHOWS a ``` block does not confuse the parser.
extract_blocks <- function(lines) {
  blocks <- list()
  in_block <- FALSE
  ticks <- 0L
  info <- ""
  buf <- character()
  start <- 0L

  for (i in seq_along(lines)) {
    line <- lines[i]
    m <- regmatches(line, regexec("^(`{3,})(.*)$", line))[[1]]

    if (!in_block && length(m) == 3) {
      # Opening fence.
      in_block <- TRUE
      ticks <- nchar(m[2])
      info <- trimws(m[3])
      buf <- character()
      start <- i
      next
    }

    if (in_block) {
      # Closing fence: at least as many backticks and nothing else on the line.
      if (length(m) == 3 && nchar(m[2]) >= ticks && trimws(m[3]) == "") {
        blocks[[length(blocks) + 1L]] <- list(info = info, code = buf, start = start)
        in_block <- FALSE
        next
      }
      buf <- c(buf, line)
    }
  }
  blocks
}

# Is this an R block we should check?
# Accepts every form the fence can take: ```r, ```r {.attr}, ```{r ...},
# ```{.r ...}. Panache normalises ```{.r .no-check} to ```r {.no-check}, so both
# have to be recognised. Otherwise a block with attributes would be skipped
# silently and nobody would notice.
# Skipped if .no-check appears in the fence.
is_r_block <- function(info) {
  if (grepl("no-check", info, fixed = TRUE)) return(FALSE)
  grepl("^\\{?\\.?r\\b", info)
}

# Lines OUTSIDE code blocks (for the prose checks: headings, callouts, tables).
prose_lines <- function(lines) {
  keep <- rep(TRUE, length(lines))
  in_block <- FALSE
  ticks <- 0L
  for (i in seq_along(lines)) {
    m <- regmatches(lines[i], regexec("^(`{3,})(.*)$", lines[i]))[[1]]
    if (!in_block && length(m) == 3) {
      in_block <- TRUE
      ticks <- nchar(m[2])
      keep[i] <- FALSE
      next
    }
    if (in_block) {
      keep[i] <- FALSE
      if (length(m) == 3 && nchar(m[2]) >= ticks && trimws(m[3]) == "") in_block <- FALSE
    }
  }
  lines[keep]
}

# 1. code - can every R block be parsed? ---------------------------------------
# Catches a missing comma, unbalanced brackets, a %>% left hanging. Exactly the
# kind of error that costs an hour on a locked-down DST server.
check_code <- function() {
  header("1. Does every R block parse?")
  n_blocks <- 0L
  n_bad <- 0L

  for (f in qmd_files()) {
    lines <- readLines(f, warn = FALSE)
    for (b in extract_blocks(lines)) {
      if (!is_r_block(b$info)) next
      n_blocks <- n_blocks + 1L

      parsed <- tryCatch(
        {
          parse(text = paste(b$code, collapse = "\n"))
          NULL
        },
        error = function(e) conditionMessage(e)
      )

      if (!is.null(parsed)) {
        n_bad <- n_bad + 1L
        msg <- sub("\n.*$", "", parsed) # first line of the error only
        fail(rel(f), ":", b$start, " - code block cannot be parsed as R: ", msg)
      }
    }
  }

  cat("Checked ", n_blocks, " R blocks, ", n_bad, " cannot be parsed.\n", sep = "")
  if (n_bad > 0) {
    cat("If a block is deliberately pseudocode, mark it ```{.r .no-check}\n")
  }
}

# 2. functions - do the functions exist? ---------------------------------------
# Catches renamed and invented functions. prepare_lpr3() was renamed to
# prepare_lpr3f() in osdc at one point, and that kind of thing must not sit and
# rot in the guide.
collect_calls <- function(expr, acc = new.env(parent = emptyenv())) {
  if (is.call(expr)) {
    head <- expr[[1]]

    if (is.symbol(head)) {
      acc[[as.character(head)]] <- ""
    } else if (is.call(head) && length(head) == 3 && is.symbol(head[[1]]) &&
      as.character(head[[1]]) %in% c("::", ":::")) {
      # pkg::fn() - store as "pkg::fn"
      acc[[paste0(as.character(head[[2]]), "::", as.character(head[[3]]))]] <- ""
    }

    for (i in seq_along(expr)) {
      if (i == 1 && is.symbol(expr[[1]])) next
      # An empty argument (the comma slot in df[, 1]) is R_MissingArg and blows
      # up on any contact. Hence tryCatch around the USE, not the extraction.
      part <- tryCatch(expr[[i]], error = function(e) NULL)
      recurse <- tryCatch(!is.null(part) && is.call(part), error = function(e) FALSE)
      if (recurse) collect_calls(part, acc)
    }
  }
  acc
}

# Funktioner defineret i selve filen (fx tf_bef, check_types, sas_to_parquet).
locally_defined <- function(exprs) {
  found <- character()
  walk <- function(e) {
    if (is.call(e)) {
      # is.symbol() first: e[[1]] can itself be a call (f(x)(y)), and then
      # as.character() returns a vector, which && will not accept.
      if (length(e) == 3 && is.symbol(e[[1]]) &&
        as.character(e[[1]]) %in% c("<-", "=", "<<-") &&
        is.symbol(e[[2]]) && is.call(e[[3]]) && is.symbol(e[[3]][[1]]) &&
        as.character(e[[3]][[1]]) %in% c("function", "\\")) {
        found <<- c(found, as.character(e[[2]]))
      }
      for (i in seq_along(e)) {
        part <- tryCatch(e[[i]], error = function(err) NULL)
        recurse <- tryCatch(!is.null(part) && is.call(part), error = function(err) FALSE)
        if (recurse) walk(part)
      }
    }
  }
  for (e in exprs) walk(e)
  found
}

check_functions <- function() {
  header("2. Do the functions we call exist?")

  # Operators and control structures that are not "functions" in this sense.
  syntax <- c(
    "<-", "<<-", "=", "==", "!=", "<", ">", "<=", ">=", "+", "-", "*", "/", "^",
    "!", "&", "&&", "|", "||", "~", ":", "::", ":::", "$", "@", "[", "[[", "(",
    "{", "if", "for", "while", "repeat", "function", "return", "break", "next",
    "%>%", "%in%", "%%", "%/%", "%||%", "...", "\\"
  )

  # Base packages are always available without library().
  base_pkgs <- c("base", "stats", "utils", "methods", "graphics", "grDevices", "datasets", "tools")
  known_base <- unlist(lapply(base_pkgs, function(p) ls(getNamespace(p))), use.names = FALSE)

  # Which packages does the guide mention at all? (library(x), require(x), x::y)
  mentioned <- character()
  for (f in qmd_files()) {
    txt <- paste(readLines(f, warn = FALSE), collapse = "\n")
    mentioned <- c(
      mentioned,
      gsub('.*\\(["\']?|["\']?\\).*', "", regmatches(txt, gregexpr('(?:library|require)\\(["\']?[A-Za-z0-9._]+["\']?\\)', txt))[[1]]),
      sub("::.*", "", regmatches(txt, gregexpr("[A-Za-z][A-Za-z0-9._]*::", txt))[[1]])
    )
  }
  # Placeholders from prose examples such as library(package) are not real packages.
  placeholders <- c("pakke", "pakkenavn", "package", "packagename", "dinpakke")
  mentioned <- setdiff(unique(gsub("[^A-Za-z0-9._]", "", mentioned)), c("", base_pkgs, placeholders))

  installed <- rownames(installed.packages())
  usable <- intersect(mentioned, installed)
  missing_pkgs <- setdiff(mentioned, installed)

  # Which package exports which function? Used to say "you call
  # CreateTableOne() but you never load tableone".
  exporter <- list()
  for (p in usable) {
    for (fn in tryCatch(getNamespaceExports(p), error = function(e) character())) {
      if (is.null(exporter[[fn]])) exporter[[fn]] <- p
    }
  }

  # library(tidyverse) gives access to the core packages without naming them.
  tidyverse_core <- c(
    "dplyr", "ggplot2", "tidyr", "readr", "purrr", "tibble",
    "stringr", "forcats", "lubridate"
  )

  # Exports for ONE list of packages (used per page, not globally).
  exports_of <- function(pkgs) {
    pkgs <- unique(pkgs)
    if ("tidyverse" %in% pkgs) pkgs <- unique(c(pkgs, tidyverse_core))
    unlist(
      lapply(intersect(pkgs, installed), function(p) {
        tryCatch(getNamespaceExports(p), error = function(e) character())
      }),
      use.names = FALSE
    )
  }

  # Egen allowlist.
  allow_file <- file.path(ROOT, ".config", "known-functions.txt")
  if (file.exists(allow_file)) {
    allow <- trimws(readLines(allow_file, warn = FALSE))
    known_base <- c(known_base, allow[nzchar(allow) & !startsWith(allow, "#")])
  }

  # "Ambient" packages: assumed loaded everywhere, so they do not need a
  # library() line in every snippet. See .config/ambient-packages.txt for why.
  ambient_file <- file.path(ROOT, ".config", "ambient-packages.txt")
  ambient <- character()
  if (file.exists(ambient_file)) {
    a <- trimws(readLines(ambient_file, warn = FALSE))
    ambient <- a[nzchar(a) & !startsWith(a, "#")]
  }
  known_base <- c(known_base, exports_of(ambient))

  known_base <- unique(c(known_base, syntax))
  n_unknown <- 0L
  n_unverifiable <- 0L
  n_undeclared <- 0L

  for (f in qmd_files()) {
    lines <- readLines(f, warn = FALSE)
    txt <- paste(lines, collapse = "\n")
    exprs <- list()
    for (b in extract_blocks(lines)) {
      if (!is_r_block(b$info)) next
      e <- tryCatch(parse(text = paste(b$code, collapse = "\n")), error = function(e) NULL)
      if (!is.null(e)) exprs <- c(exprs, as.list(e))
    }
    if (!length(exprs)) next

    # Which packages does THIS page rely on, and are any missing locally? If so,
    # we cannot tell whether an unknown call is an error or just a function from
    # a package we do not have. Then it is noise, not a finding.
    file_pkgs <- gsub(
      '.*\\(["\']?|["\']?\\).*', "",
      regmatches(txt, gregexpr('(?:library|require)\\(["\']?[A-Za-z0-9._]+["\']?\\)', txt))[[1]]
    )
    file_pkgs <- setdiff(unique(gsub("[^A-Za-z0-9._]", "", file_pkgs)), c("", base_pkgs, placeholders))
    unresolvable <- setdiff(file_pkgs, installed)

    # Known ON THIS PAGE = base + the packages the page loads ITSELF + what the
    # page defines itself + the allowlist. Deliberately NOT packages some other
    # page happens to load: a reader lands on one page and runs its code, not
    # the whole site's.
    file_known <- c(known_base, exports_of(file_pkgs), locally_defined(exprs))

    acc <- new.env(parent = emptyenv())
    for (e in exprs) collect_calls(e, acc)
    calls <- ls(acc)

    # pkg::fn - here we KNOW which package is meant, so this is a hard check.
    qualified <- grep("::", calls, value = TRUE, fixed = TRUE)
    plain <- setdiff(calls, qualified)

    for (q in qualified) {
      pkg <- sub("::.*", "", q)
      fn <- sub(".*::", "", q)
      if (!pkg %in% installed) {
        n_unverifiable <- n_unverifiable + 1L
        next
      }
      if (!fn %in% tryCatch(getNamespaceExports(pkg), error = function(e) character())) {
        n_unknown <- n_unknown + 1L
        fail(rel(f), " - ", q, "() does NOT exist in ", pkg, ". Renamed or invented?")
      }
    }

    unknown <- setdiff(plain, file_known)
    if (!length(unknown)) next

    # Does the function exist in an installed package that the page simply never
    # loads? Then it is not an invented function but a missing library() line,
    # and the reader gets "could not find function" on the first run.
    undeclared <- unknown[!vapply(unknown, function(x) is.null(exporter[[x]]), logical(1))]
    genuinely_unknown <- setdiff(unknown, undeclared)

    for (x in undeclared) {
      n_undeclared <- n_undeclared + 1L
      warn(rel(f), " - calls ", x, "() but never loads library(", exporter[[x]], ")")
    }

    if (!length(genuinely_unknown)) next

    if (length(unresolvable)) {
      # The page uses packages we do not have installed. Cannot be decided.
      n_unverifiable <- n_unverifiable + length(genuinely_unknown)
    } else {
      # All the page's packages are installed, and the function still exists nowhere.
      n_unknown <- n_unknown + length(genuinely_unknown)
      warn(rel(f), " - ukendte funktioner: ", paste(sort(genuinely_unknown), collapse = ", "))
    }
  }

  cat("Installed and verified: ", paste(sort(usable), collapse = ", "), "\n\n", sep = "")
  if (length(missing_pkgs)) {
    cat(
      "NOT installed locally (", length(missing_pkgs), " packages), so ", n_unverifiable,
      " calls cannot be verified:\n  ",
      paste(sort(missing_pkgs), collapse = ", "), "\n",
      "Install them for full coverage, especially osdc and fastreg, which the guide leans on heavily.\n\n",
      sep = ""
    )
  }
  cat(n_undeclared, " calls use a package the page never loads (missing library()).\n", sep = "")
  cat(n_unknown, " calls look genuinely wrong.\n", sep = "")
}

# 3. style - the house rules from CLAUDE.md ------------------------------------
check_style <- function() {
  header("3. House rules (em dash, %>%, colon after labels, formatter damage)")

  n <- 0L
  for (f in qmd_files()) {
    lines <- readLines(f, warn = FALSE)

    # Formatter damage. panache-cli escapes link brackets and indents callouts
    # under the preceding list, so the link renders as raw text and the callout
    # becomes list continuation. Both are silent in the build, so they have to
    # be caught here. See _ignore/TODO.md.
    hits <- grep("\\\\\\[|\\\\\\]", lines)
    for (i in hits) {
      n <- n + 1L
      fail(rel(f), ":", i, " - escaped link bracket (\\[ or \\]). Renders as raw text, not as a link.")
    }
    hits <- grep("^\\s+:::", lines)
    for (i in hits) {
      n <- n + 1L
      fail(rel(f), ":", i, " - indented ::: (callout swallowed by a list). Must start in column 0.")
    }

    # A list flattened into prose. The signature is an intro ending in a colon
    # followed by " - " mid-paragraph: pandoc renders that as one paragraph, not
    # as a list, so the bullets disappear silently.
    prose <- prose_lines(lines)
    flat <- grep(":\\s+- (\\*\\*|\\[|`|[A-Z])", prose, value = TRUE)
    for (b in flat) {
      n <- n + 1L
      fail(rel(f), " - list flattened into prose (missing blank line after the colon): ", substr(trimws(b), 1, 55), "...")
    }

    # No em dash (U+2014). Applies to all content.
    hits <- grep("—", lines)
    for (i in hits) {
      n <- n + 1L
      fail(rel(f), ":", i, " - em-dash (U+2014). Brug komma, kolon, parentes eller ' - '.")
    }

    # %>% not |>, but ONLY in actual R code. The guide deliberately explains the
    # difference between %>% and |> in prose (r-intro, function-guide), and
    # that kind of mention is not a style violation.
    for (b in extract_blocks(lines)) {
      if (!is_r_block(b$info)) next
      hits <- grep("|>", b$code, fixed = TRUE)
      for (h in hits) {
        n <- n + 1L
        fail(rel(f), ":", b$start + h, " - native pipe |> i kode. Guiden bruger %>%.")
      }
    }

    # Colon (not " - ") after a bold or linked label in a list item.
    prose <- prose_lines(lines)
    bad_label <- grep("^\\s*[-*] (\\*\\*[^*]+\\*\\*|\\[[^]]+\\]\\([^)]*\\)) - ", prose, value = TRUE)
    for (b in bad_label) {
      n <- n + 1L
      warn(rel(f), " - list item uses ' - ' after the label, should be a colon: ", substr(trimws(b), 1, 60), "...")
    }
  }

  cat(n, " style violations found.\n", sep = "")
}

# 4. links - do internal .qmd links and anchors resolve? -----------------------
# lychee (just check-urls) checks ONLY http/mailto, not internal links, and
# Quarto reports a dead internal link as a warning, not an error. So the build
# succeeds and the link simply goes nowhere. After a rename this is the easiest
# mistake to make and the hardest to spot.
#
# Anchors are worse still: page.qmd#anchor-that-does-not-exist lands at the top
# of the right page, so it looks like it works. So we derive the id for every
# heading using pandoc's rules and look the link's anchor up in that list.

# Pandoc's auto_identifiers, in the order pandoc itself applies them:
#   1) remove formatting and links (keep the link text)
#   2) remove everything that is not alphanumeric, underscore, hyphen or dot
#   3) mellemrum -> bindestreger
#   4) lowercase
#   5) drop everything before the first letter (an id must not start with a digit)
# Note the order of 2 and 3: " - " becomes "---", not "-".
heading_id <- function(txt) {
  x <- sub("\\{[^}]*\\}\\s*$", "", txt)                  # eksplicitte attributter
  x <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", x)        # [tekst](url) -> tekst
  x <- gsub("[*_`]", "", x)                              # fed, kursiv, kode
  x <- gsub("[^[:alnum:] _.-]", "", x)
  x <- gsub("[[:space:]]+", "-", trimws(x))
  x <- tolower(x)
  sub("^[^a-z]+", "", x)
}

# Every id a page offers: explicit {#id} (headings, divs, figures) plus the
# derived heading ids. Repeated ids get -1, -2 ... as pandoc does.
page_ids <- function(lines) {
  prose <- prose_lines(lines)
  # An id can sit anywhere in an attribute block, not only first: headings write
  # {#id .class}, but callouts and fenced divs write {.callout-note #id}. So take
  # the whole {...} block and pull every #token out of it. A dot is allowed
  # INSIDE an id (e.g. {#as.integer-x-1l}), so it must not terminate it.
  attrs <- unlist(regmatches(prose, gregexpr("\\{[^}]*\\}", prose)))
  explicit <- unlist(regmatches(
    attrs, gregexpr("(?<=[{[:space:]])#[^}[:space:]]+", attrs, perl = TRUE)
  ))
  explicit <- sub("^#", "", explicit)

  # raw HTML counts too: <details id="..."> and <div id="...">
  html <- unlist(regmatches(prose, gregexpr("id=\"[^\"]+\"", prose)))
  html <- gsub("^id=\"|\"$", "", html)
  explicit <- c(explicit, html)

  ids <- character()
  seen <- character()
  for (l in prose) {
    if (!grepl("^#{1,6} ", l)) next
    if (grepl("\\{#[^}]*\\}\\s*$", l)) next                # already has an explicit id
    id <- heading_id(sub("^#{1,6} ", "", l))
    if (!nzchar(id)) next
    n <- sum(seen == id)
    seen <- c(seen, id)
    if (n > 0) id <- paste0(id, "-", n)
    ids <- c(ids, id)
  }
  unique(c(explicit, ids))
}

check_links <- function() {
  header("4. Do internal .qmd links and anchors point at something real?")

  n_checked <- 0L
  n_bad <- 0L
  n_anchors <- 0L

  ids_cache <- new.env(parent = emptyenv())
  ids_for <- function(path) {
    key <- normalizePath(path, mustWork = FALSE)
    if (is.null(ids_cache[[key]])) {
      ids_cache[[key]] <- if (file.exists(key)) page_ids(readLines(key, warn = FALSE)) else character()
    }
    ids_cache[[key]]
  }

  check_anchor <- function(target_file, anchor, where, shown) {
    if (!nzchar(anchor)) return(invisible(NULL))
    # Quarto generates its own anchors for cross-references (fig-, tbl-, eq-,
    # sec-, lst-, thm-) and for code cells - we cannot see those in the source.
    if (grepl("^(fig|tbl|eq|sec|lst|thm|cell)-", anchor)) return(invisible(NULL))
    n_anchors <<- n_anchors + 1L
    if (!anchor %in% ids_for(target_file)) {
      n_bad <<- n_bad + 1L
      fail(where, " - anchor does not exist: ", shown)
    }
  }

  # External URLs and root-absolute paths (which Quarto resolves itself) are not
  # our business. The guard must sit on the RAW link, not on the resolved path:
  # that one is always absolute and would otherwise skip everything.
  skip_target <- function(raw) grepl("^(https?:|mailto:|/)", raw)

  check_target <- function(raw, resolved, where) {
    if (skip_target(raw)) return(invisible(NULL))
    n_checked <<- n_checked + 1L
    if (!file.exists(resolved)) {
      n_bad <<- n_bad + 1L
      fail(where, " - dead internal link: ", raw)
    }
  }

  for (f in qmd_files()) {
    lines <- readLines(f, warn = FALSE)
    prose <- prose_lines(lines)   # code blocks do not count
    dir <- dirname(f)
    for (i in seq_along(prose)) {
      where <- paste0(rel(f), ":", i)

      # links to another page, optionally with an anchor: ](page.qmd#anchor)
      hits <- gregexpr("\\]\\([^)[:space:]]+\\.qmd(#[^)[:space:]]*)?\\)", prose[i])[[1]]
      if (hits[1] != -1) {
        for (j in seq_along(hits)) {
          raw <- substr(prose[i], hits[j], hits[j] + attr(hits, "match.length")[j] - 1L)
          link <- sub("^\\]\\(", "", sub("\\)$", "", raw))
          target <- sub("#.*$", "", link)
          anchor <- if (grepl("#", link)) sub("^[^#]*#", "", link) else ""
          check_target(target, file.path(dir, target), where)
          if (!skip_target(target) && file.exists(file.path(dir, target))) {
            check_anchor(file.path(dir, target), anchor, where, link)
          }
        }
      }

      # links within the same page: ](#anchor)
      hits <- gregexpr("\\]\\(#[^)[:space:]]+\\)", prose[i])[[1]]
      if (hits[1] != -1) {
        for (j in seq_along(hits)) {
          raw <- substr(prose[i], hits[j], hits[j] + attr(hits, "match.length")[j] - 1L)
          anchor <- sub("^\\]\\(#", "", sub("\\)$", "", raw))
          check_anchor(f, anchor, where, paste0("#", anchor))
        }
      }
    }
  }

  # the sidebar and navbar in _quarto.yml also point at files
  yml <- readLines(file.path(ROOT, "_quarto.yml"), warn = FALSE)
  hits <- regmatches(yml, regexpr("[[:alnum:]._/-]+\\.qmd", yml))
  for (h in hits) check_target(h, file.path(ROOT, h), "_quarto.yml")

  cat("Checked ", n_checked, " internal links and ", n_anchors, " anchors, ", n_bad, " dead.\n", sep = "")
}

# 5. schema - is it valid, and are the generated tables up to date? ------------
# Two separate questions.
#
# Validity: do the schema's own references resolve, are the types in the allowed
# set, is anything duplicated. That check lives WITH the schema
# (schema/R/validate_schema.R), because it travels to whatever repo consumes it.
#
# Drift: does _generated/ still match what the schema produces. Without this,
# "single source of truth" is a hope, not a fact: someone edits the YAML and
# forgets to run `just build-schema-tables`, or edits the generated markdown by
# hand, and the page and the schema quietly disagree.

check_schema <- function() {
  header("5. Is the schema valid, and are the generated tables current?")

  schema_dir <- file.path(ROOT, "schema")
  if (!dir.exists(schema_dir)) {
    cat("No schema/ directory - skipped.\n")
    return(invisible())
  }
  if (!requireNamespace("yaml", quietly = TRUE)) {
    cat("The 'yaml' package is not installed, so the schema cannot be checked.\n")
    cat("install.packages('yaml')\n")
    return(invisible())
  }

  source(file.path(schema_dir, "R", "load_schema.R"), local = TRUE)
  source(file.path(schema_dir, "R", "validate_schema.R"), local = TRUE)

  schema <- load_schema(schema_dir)
  found <- validate_schema(schema)
  for (i in seq_len(nrow(found))) {
    if (found$severity[i] == "error") fail("schema - ", found$message[i])
    else warn("schema - ", found$message[i])
  }
  cat("Checked ", length(schema$registers), " registers and ",
      length(schema$code_systems), " code systems, ",
      sum(found$severity == "error"), " errors.\n", sep = "")

  # Regenerate into a temp dir and compare, file by file.
  gen_dir <- file.path(ROOT, "_generated")
  tmp <- file.path(tempdir(), "schema-tables-check")
  unlink(tmp, recursive = TRUE)
  old_out <- Sys.getenv("SCHEMA_TABLES_OUT", unset = NA)
  Sys.setenv(SCHEMA_TABLES_OUT = tmp)
  on.exit({
    if (is.na(old_out)) Sys.unsetenv("SCHEMA_TABLES_OUT")
    else Sys.setenv(SCHEMA_TABLES_OUT = old_out)
  }, add = TRUE)

  invisible(capture.output(
    suppressWarnings(try(
      source(file.path(ROOT, "tools", "build-schema-tables.R"), local = new.env()),
      silent = TRUE
    ))
  ))

  if (!dir.exists(tmp)) {
    fail("schema - could not regenerate the tables to compare against _generated/")
    return(invisible())
  }
  fresh <- list.files(tmp, pattern = "\\.md$")
  n_drift <- 0
  for (f in fresh) {
    committed <- file.path(gen_dir, f)
    if (!file.exists(committed)) {
      fail("_generated/", f, " is missing. Run: just build-schema-tables")
      n_drift <- n_drift + 1
    } else if (!identical(readLines(committed, warn = FALSE),
                          readLines(file.path(tmp, f), warn = FALSE))) {
      fail("_generated/", f, " does not match the schema. Run: just build-schema-tables")
      n_drift <- n_drift + 1
    }
  }
  for (f in setdiff(list.files(gen_dir, pattern = "\\.md$"), fresh)) {
    warn("_generated/", f, " has no register in the schema - left over from a rename?")
  }

  # The variable index lives in assets/ rather than _generated/, because Quarto
  # does not copy anything under a directory starting with an underscore and the
  # browser fetches this one at runtime. It drifts the same way, so check it too.
  # The search index is harvested from the .qmd sources, so it goes stale the
  # moment a page is added, renamed or rewritten. Same drift check as the tables.
  si <- file.path(ROOT, "assets", "search-index.json")
  si_tmp <- file.path(tempdir(), "search-index-check")
  unlink(si_tmp, recursive = TRUE)
  old_si <- Sys.getenv("SEARCH_INDEX_OUT", unset = NA)
  Sys.setenv(SEARCH_INDEX_OUT = si_tmp)
  invisible(capture.output(suppressWarnings(try(
    source(file.path(ROOT, "tools", "build-search-index.R"), local = new.env()),
    silent = TRUE))))
  if (is.na(old_si)) Sys.unsetenv("SEARCH_INDEX_OUT") else Sys.setenv(SEARCH_INDEX_OUT = old_si)
  si_fresh <- file.path(si_tmp, "search-index.json")
  if (!file.exists(si)) {
    fail("assets/search-index.json is missing. Run: just build-search-index")
    n_drift <- n_drift + 1
  } else if (file.exists(si_fresh) &&
             !identical(readLines(si, warn = FALSE), readLines(si_fresh, warn = FALSE))) {
    fail("assets/search-index.json does not match the guide. Run: just build-search-index")
    n_drift <- n_drift + 1
  }

  vj <- file.path(ROOT, "assets", "variables.json")
  vj_fresh <- file.path(dirname(tmp), "assets", "variables.json")
  if (!file.exists(vj)) {
    fail("assets/variables.json is missing. Run: just build-schema-tables")
    n_drift <- n_drift + 1
  } else if (file.exists(vj_fresh) &&
             !identical(readLines(vj, warn = FALSE), readLines(vj_fresh, warn = FALSE))) {
    fail("assets/variables.json does not match the schema. Run: just build-schema-tables")
    n_drift <- n_drift + 1
  }
  cat("Compared ", length(fresh), " generated table(s), ", n_drift, " out of date.\n", sep = "")
}

# Run --------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
what <- if (length(args)) args[1] else "all"

if (what %in% c("all", "code")) check_code()
if (what %in% c("all", "functions")) check_functions()
if (what %in% c("all", "style")) check_style()
if (what %in% c("all", "links")) check_links()
if (what %in% c("all", "schema")) check_schema()

header("Result")

if (length(FINDINGS$warnings)) {
  cat("\nWARNINGS (", length(FINDINGS$warnings), "):\n", sep = "")
  cat(paste0("  ! ", FINDINGS$warnings, collapse = "\n"), "\n", sep = "")
}

if (length(FINDINGS$errors)) {
  cat("\nERRORS (", length(FINDINGS$errors), "):\n", sep = "")
  cat(paste0("  x ", FINDINGS$errors, collapse = "\n"), "\n", sep = "")
  cat("\nAlso remember: just check-urls (dead links) and just check-spelling.\n")
  quit(status = 1)
}

cat("\nAll OK. Also remember: just check-urls (dead links) and just check-spelling.\n")
