#!/usr/bin/env Rscript

#-----------------------------------------------------
# build-code-examples.R - saml al engelsk kode i én fil
#-----------------------------------------------------
# Bygger dst_code_examples.R: hver R-blok fra guidens .qmd-sider i roden, i
# ÉN fil man kan uploade til DST og teste af der.
#
# Brug:  Rscript tools/build-code-examples.R
#        just build-code-examples
#
# Kun base R, ingen pakker at installere.
#
# Udeladt med vilje:
#   - blokke med simulerede data (synth_data / fakeregs): de virker ikke på DST
#   - ```{.r .no-check}-blokke: bevidst ugyldig pseudokode
#   - osdc.qmd: fryses indtil det store forberedelses-script er færdigt,
#     så udkast ikke havner i den fil, folk uploader (FROZEN nedenfor)
#
# Sidetitler og filnavne genbruges fra den forrige udgave af bundlen, så
# navnene er stabile. Nye sider får et navn udledt af titlen.
#-----------------------------------------------------

ROOT <- normalizePath(file.path(dirname(sub("--file=", "", grep("--file=", commandArgs(FALSE), value = TRUE)[1])), ".."))
if (is.na(ROOT) || !dir.exists(ROOT)) ROOT <- getwd()

OUT <- file.path(ROOT, "dst_code_examples.R")

# Sider der IKKE må bygges fra arbejdsmappen, men fra sidst committede udgave.
FROZEN <- c("osdc.qmd")

RULE_EQ <- paste0("#", strrep("=", 78))
RULE_DASH <- paste0("#", strrep("-", 78))

#-----------------------------------------------------
# Pil R-blokke ud af en .qmd (samme fence-håndtering som check-guide.R)
#-----------------------------------------------------
extract_blocks <- function(lines) {
  blocks <- list()
  in_block <- FALSE
  ticks <- 0L
  info <- ""
  buf <- character()
  context <- ""      # sidste overskrift/fed indledning før blokken
  block_context <- ""

  for (ln in lines) {
    fence <- regmatches(ln, regexpr("^`{3,}", ln))
    if (length(fence) == 1) {
      n <- nchar(fence)
      if (!in_block) {
        in_block <- TRUE
        ticks <- n
        info <- sub("^`+", "", ln)
        buf <- character()
        block_context <- context
        next
      } else if (n >= ticks) {
        in_block <- FALSE
        if (is_r_block(info)) {
          blocks[[length(blocks) + 1L]] <- list(code = buf, context = block_context)
        }
        next
      }
    }
    if (in_block) {
      buf <- c(buf, ln)
    } else if (grepl("^#+ |^\\*\\*", ln)) {
      context <- ln
    }
  }
  blocks
}

# Gør en markdown-overskrift/fed indledning til en læsbar blok-overskrift.
clean_context <- function(x) {
  x <- sub("^#+\\s*", "", x)
  x <- gsub("\\*\\*|`|\\{[^}]*\\}", "", x)
  x <- gsub("\\[([^]]*)\\]\\([^)]*\\)", "\\1", x)   # links -> ren tekst
  trimws(sub("[:\\-\\s]+$", "", trimws(x)))
}

# Tæller som R-blok: ```r, ```{r}, ```{.r}. Ikke .no-check (ugyldig med vilje).
is_r_block <- function(info) {
  info <- trimws(tolower(info))
  if (grepl("no-check", info, fixed = TRUE)) return(FALSE)
  grepl("^r$|^r[[:space:]]|^\\{[[:space:]]*\\.?r[[:space:]}]", info)
}

# Simulerede data virker ikke på DST-serveren, så de blokke tages ikke med.
is_simulated <- function(code) {
  any(grepl("synth_data|fakeregs", code))
}

#-----------------------------------------------------
# Overskrift til en blok: første kommentar i blokken
#-----------------------------------------------------
# Står der en ren kommentarlinje øverst, bliver DEN til overskriften og
# fjernes fra koden. Ellers bruges den første efterhængte kommentar, og
# linjen bliver stående, som den er.
trim_blank_edges <- function(x) {
  while (length(x) && !nzchar(trimws(x[1]))) x <- x[-1]
  while (length(x) && !nzchar(trimws(x[length(x)]))) x <- x[-length(x)]
  x
}

# En kommentar duer ikke som overskrift, hvis den bare er en streg-/lighedstegns-
# ramme (#===== / #-----) eller tom.
is_banner <- function(txt) {
  !nzchar(txt) || grepl("^[-=*#_[:space:]]+$", txt)
}

comment_text <- function(line) trimws(sub("^[^#]*#+\\s*", "", line))

block_title <- function(block) {
  code <- trim_blank_edges(block$code)   # tomme linjer INDE i blokken bevares
  if (!length(code)) return(list(title = "code", body = character()))

  # 1) rene kommentarlinjer øverst: første brugbare bliver overskrift og
  #    fjernes fra koden (rammer springes over, men bliver stående)
  i <- 1L
  while (i <= length(code) && grepl("^\\s*#", code[i])) {
    txt <- comment_text(code[i])
    if (!is_banner(txt)) {
      # hele den indledende ramme ryger med: streger over OG under titlen
      end <- i
      while (end < length(code) && grepl("^\\s*#", code[end + 1L]) &&
             is_banner(comment_text(code[end + 1L]))) {
        end <- end + 1L
      }
      return(list(title = txt, body = trim_blank_edges(code[-(1:end)]), src = "leading"))
    }
    i <- i + 1L
  }

  # 2) ellers første efterhængte kommentar - linjen bliver stående
  for (ln in code) {
    if (!grepl("#", ln, fixed = TRUE)) next
    txt <- comment_text(ln)
    if (!is_banner(txt)) return(list(title = txt, body = code, src = "trailing"))
  }

  # 3) ellers den nærmeste overskrift/fede indledning før blokken i qmd'en
  ctx <- clean_context(block$context)
  list(title = if (nzchar(ctx)) ctx else "code", body = code, src = "context")
}

#-----------------------------------------------------
# Overskrifter fra den forrige bundle (håndskrevne - dem vil vi beholde)
#-----------------------------------------------------
# Er en blok uændret, genbruger vi den gamle overskrift. Kun nye og ændrede
# blokke får en maskinudledt en.
previous_titles <- function() {
  if (!file.exists(OUT)) return(list())
  lines <- readLines(OUT, warn = FALSE)
  hd <- grep("^# [0-9]+\\. ", lines)
  out <- list()
  for (i in hd) {
    if (i < 2 || !grepl("^#-{5,}", lines[i - 1])) next
    title <- sub("^# [0-9]+\\. ", "", lines[i])
    start <- i + 3L
    j <- start
    while (j <= length(lines) && !grepl("^#-{5,}|^#={5,}", lines[j])) j <- j + 1L
    body <- trim_blank_edges(lines[start:(j - 1L)])
    if (length(body)) out[[digest_body(body)]] <- title
  }
  out
}

# Nøgle til en blok: koden uden tomme linjer og uden indrykning.
digest_body <- function(body) {
  b <- trimws(body)
  paste(b[nzchar(b)], collapse = "\n")
}

truncate_title <- function(x, width = 69L) {
  if (nchar(x) <= width) x else paste0(substr(x, 1L, width), "...")
}

#-----------------------------------------------------
# Titel fra qmd'ens YAML (title:, evt. som >- blok)
#-----------------------------------------------------
qmd_title <- function(lines) {
  end <- which(lines == "---")
  if (length(end) < 2) return(NA_character_)
  yaml <- lines[(end[1] + 1L):(end[2] - 1L)]
  i <- grep("^title:", yaml)
  if (!length(i)) return(NA_character_)
  val <- trimws(sub("^title:\\s*", "", yaml[i[1]]))
  if (val %in% c(">-", ">", "|", "|-")) {
    j <- i[1] + 1L
    val <- ""
    while (j <= length(yaml) && grepl("^\\s+\\S", yaml[j])) {
      val <- trimws(paste(val, trimws(yaml[j])))
      j <- j + 1L
    }
  }
  trimws(gsub('^"|"$', "", val))
}

# Filnavn til en side, der ikke fandtes i den forrige bundle.
derive_name <- function(qmd, title) {
  num <- regmatches(basename(qmd), regexpr("^[0-9]+[a-z]?", basename(qmd)))
  slug <- tolower(title)
  slug <- gsub("[^a-z0-9 ]", " ", slug)
  words <- setdiff(strsplit(trimws(slug), "\\s+")[[1]], c("a", "an", "the", "and", "to", "of", "for", "in", "on", "your"))
  paste0(paste(c(num, words), collapse = "_"), ".R")
}

#-----------------------------------------------------
# Læs navne og rækkefølge fra den forrige bundle
#-----------------------------------------------------
previous_sections <- function() {
  if (!file.exists(OUT)) return(NULL)
  lines <- readLines(OUT, warn = FALSE)
  fl <- grep("^# FILE: ", lines)
  if (!length(fl)) return(NULL)
  out <- data.frame(qmd = character(), name = character(), stringsAsFactors = FALSE)
  for (i in fl) {
    name <- trimws(sub("^# FILE: ", "", lines[i]))
    meta <- lines[i + 1L]
    src <- regmatches(meta, regexpr("[^[:space:]]+\\.qmd", meta))
    if (length(src) == 1) out <- rbind(out, data.frame(qmd = src, name = name, stringsAsFactors = FALSE))
  }
  out
}

#-----------------------------------------------------
# Kildelinjer for en side: frosne sider læses fra HEAD
#-----------------------------------------------------
source_lines <- function(qmd) {
  if (qmd %in% FROZEN) {
    txt <- suppressWarnings(system2("git", c("show", paste0("HEAD:", qmd)), stdout = TRUE, stderr = FALSE))
    if (!is.null(attr(txt, "status")) && attr(txt, "status") != 0) {
      stop("kunne ikke læse ", qmd, " fra HEAD")
    }
    return(txt)
  }
  readLines(file.path(ROOT, qmd), warn = FALSE)
}

#-----------------------------------------------------
# Byg
#-----------------------------------------------------
prev <- previous_sections()
prev_titles <- previous_titles()
reused <- 0L

# Guidens sider ligger i roden. README/404 er ikke guideindhold, og darter/ er
# projektspecifikt og har aldrig været med i bundlen.
all_qmd <- sort(list.files(ROOT, pattern = "\\.qmd$"))
all_qmd <- setdiff(all_qmd, c("README.qmd", "404.qmd"))

# Rækkefølge: som i forrige bundle, derefter nye sider bagest.
order_qmd <- if (is.null(prev)) all_qmd else c(prev$qmd, setdiff(all_qmd, prev$qmd))
order_qmd <- order_qmd[order_qmd %in% all_qmd | order_qmd %in% FROZEN]

pages <- list()
for (qmd in order_qmd) {
  lines <- source_lines(qmd)
  blocks <- extract_blocks(lines)
  blocks <- Filter(function(b) !is_simulated(b$code), blocks)
  blocks <- Filter(function(b) any(nzchar(trimws(b$code))), blocks)
  if (!length(blocks)) next

  title <- qmd_title(lines)
  if (is.na(title)) title <- basename(qmd)
  name <- if (!is.null(prev) && qmd %in% prev$qmd) prev$name[match(qmd, prev$qmd)] else derive_name(qmd, title)

  pages[[length(pages) + 1L]] <- list(qmd = qmd, title = title, name = name, blocks = blocks)
}

n_pages <- length(pages)

#-----------------------------------------------------
# Skriv filen
#-----------------------------------------------------
out <- c(
  RULE_EQ,
  "#  DST REGISTER-BASED RESEARCH  -  ALL CODE EXAMPLES  (one-file bundle)",
  "#",
  "#  English code from every guide page, in reading order. Simulated-data",
  "#  blocks (synth_data / fakeregs) are excluded on purpose.",
  "#",
  "#  HOW TO USE INSIDE DST",
  "#  Upload this ONE file. Each page is a #==== headline box whose",
  '#  "# FILE: <name>.R" line names the .R file it should become. To split it',
  "#  into separate .R files your colleagues can use, run the SPLITTER below",
  "#  once (writes to ./code_examples/). Or copy any section by hand.",
  "#",
  "#  These are REFERENCE snippets: they assume their own objects/paths and are",
  "#  meant to be adapted per task, not sourced top-to-bottom.",
  "#",
  "#  Generated by tools/build-code-examples.R - do not edit by hand.",
  RULE_EQ,
  "",
  "#  ------------------------  SPLITTER  (run once)  -------------------------",
  "#  Change FALSE to TRUE, then run this block. It reads THIS file and writes",
  "#  each  # FILE:  section to its own .R file in ./code_examples/.",
  "if (FALSE) {",
  '  src    <- "dst_code_examples.R"        # <- this file\'s name on the server',
  "  lines  <- readLines(src, warn = FALSE)",
  '  fl     <- grep("^# FILE: ", lines)      # the  # FILE: <name>.R  lines',
  "  stopifnot(length(fl) > 0)",
  "  starts <- fl - 1L                       # include the #==== rule above each",
  "  ends   <- c(starts[-1] - 1L, length(lines))",
  '  outdir <- "code_examples"; dir.create(outdir, showWarnings = FALSE)',
  "  for (k in seq_along(fl)) {",
  '    nm <- trimws(sub("^# FILE: ", "", lines[fl[k]]))',
  "    writeLines(lines[starts[k]:ends[k]], file.path(outdir, nm))",
  "  }",
  '  message("Wrote ", length(fl), " files to ", normalizePath(outdir))',
  "}",
  paste0("#  ", strrep("-", 73)),
  "",
  "#  CONTENTS  (files the splitter produces)"
)

pad <- max(nchar(vapply(pages, function(p) p$name, character(1)))) + 2L
for (p in pages) {
  out <- c(out, paste0("#    ", formatC(p$name, width = -pad), p$title))
}
out <- c(out, RULE_EQ, "")

for (i in seq_along(pages)) {
  p <- pages[[i]]
  out <- c(
    out,
    "",
    RULE_EQ,
    paste0("# FILE: ", p$name),
    paste0("# ", p$title, "   ·   page ", i, "/", n_pages, "   ·   source: ", p$qmd),
    RULE_EQ,
    ""
  )
  for (j in seq_along(p$blocks)) {
    bt <- block_title(p$blocks[[j]])
    if (!length(bt$body)) next
    # En kommentar øverst i blokken er forfatterens egen overskrift og vinder
    # over den gamle. Kun blokke uden får genbrugt den håndskrevne titel.
    old <- if (identical(bt$src, "leading")) NULL else prev_titles[[digest_body(bt$body)]]
    if (!is.null(old)) {
      bt$title <- old            # uændret blok: behold den håndskrevne overskrift
      reused <- reused + 1L
    }
    out <- c(
      out,
      RULE_DASH,
      paste0("# ", j, ". ", truncate_title(bt$title)),
      RULE_DASH,
      "",
      bt$body,
      ""
    )
  }
}

writeLines(out, OUT)

cat("Skrev", OUT, "\n")
cat(n_pages, "sider,", sum(vapply(pages, function(p) length(p$blocks), integer(1))), "kodeblokke\n")
cat("Genbrugte overskrifter fra forrige udgave:", reused, "\n")
if (length(FROZEN)) cat("Frosset (læst fra HEAD):", paste(FROZEN, collapse = ", "), "\n")
