#!/usr/bin/env Rscript

#-----------------------------------------------------
# check-guide.R - ugentligt tjek af guiden
#-----------------------------------------------------
# Kører fire tjek, som Quarto-bygningen IKKE fanger:
#
#   code      Kan hver ```r-blok overhovedet parses som R?
#   functions Findes de funktioner, vi kalder, rent faktisk?
#   parity    Har da/ og en/ samme struktur?
#   style     Overholder vi husreglerne (ingen em-dash, %>% ikke |>, kolon efter labels)?
#
# Brug:  Rscript tools/check-guide.R [all|code|functions|parity|style]
#        just check-guide
#
# Kun base R, ingen pakker at installere.
#
# Undtagelser:
#   - En kodeblok, der med vilje ikke er gyldig R (pseudokode), markeres med
#     ```{.r .no-check} - den beholder R-farvelægningen, men springes over her.
#   - Funktionsnavne, tjekket ikke kan slå op, kan tilføjes i
#     .config/known-functions.txt (ét navn per linje).
#-----------------------------------------------------

ROOT <- normalizePath(file.path(dirname(sub("--file=", "", grep("--file=", commandArgs(FALSE), value = TRUE)[1])), ".."))
if (is.na(ROOT) || !dir.exists(ROOT)) ROOT <- getwd()

# Fejl og advarsler samles her og printes til sidst.
FINDINGS <- new.env(parent = emptyenv())
FINDINGS$errors <- character()
FINDINGS$warnings <- character()

fail <- function(...) FINDINGS$errors <- c(FINDINGS$errors, paste0(...))
warn <- function(...) FINDINGS$warnings <- c(FINDINGS$warnings, paste0(...))

header <- function(txt) cat("\n", txt, "\n", strrep("-", nchar(txt)), "\n", sep = "")

qmd_files <- function() {
  c(
    list.files(file.path(ROOT, "da"), pattern = "\\.qmd$", full.names = TRUE),
    list.files(file.path(ROOT, "en"), pattern = "\\.qmd$", full.names = TRUE)
  )
}

rel <- function(path) sub(paste0("^", ROOT, "/"), "", path)

#-----------------------------------------------------
# Fælles: pil kodeblokke ud af en .qmd-fil
#-----------------------------------------------------
# Returnerer en liste af blokke: info (fence-teksten), code (linjerne),
# start (linjenummer for fence-linjen). Håndterer fences med 3+ backticks,
# så en ```` ```` -blok, der VISER en ```-blok, ikke forvirrer parseren.
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
      # Åbnende fence.
      in_block <- TRUE
      ticks <- nchar(m[2])
      info <- trimws(m[3])
      buf <- character()
      start <- i
      next
    }

    if (in_block) {
      # Lukkende fence: mindst lige så mange backticks og intet andet på linjen.
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

# Er det en R-blok, vi skal tjekke?
# Accepterer alle de former, fencen kan have: ```r, ```r {.attr}, ```{r ...},
# ```{.r ...}. Panache normaliserer ```{.r .no-check} til ```r {.no-check}, så
# begge skal genkendes, ellers ville en blok med attributter stille blive sprunget
# over uden at nogen opdagede det.
# Sprunget over hvis .no-check står i fencen.
is_r_block <- function(info) {
  if (grepl("no-check", info, fixed = TRUE)) return(FALSE)
  grepl("^\\{?\\.?r\\b", info)
}

# Linjer UDEN for kodeblokke (til prosa-tjek: overskrifter, callouts, tabeller).
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

#-----------------------------------------------------
# 1. code - kan hver R-blok parses?
#-----------------------------------------------------
# Fanger manglende komma, ubalancerede parenteser, et %>% der hænger i luften.
# Præcis den slags fejl, der koster en time på en låst DST-server.
check_code <- function() {
  header("1. Parser alle R-blokke?")
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
        msg <- sub("\n.*$", "", parsed) # kun første linje af fejlen
        fail(rel(f), ":", b$start, " - kodeblokken kan ikke parses som R: ", msg)
      }
    }
  }

  cat("Tjekkede ", n_blocks, " R-blokke, ", n_bad, " kan ikke parses.\n", sep = "")
  if (n_bad > 0) {
    cat("Er en blok pseudokode med vilje, så marker den med ```{.r .no-check}\n")
  }
}

#-----------------------------------------------------
# 2. functions - findes funktionerne?
#-----------------------------------------------------
# Fanger omdøbte og opdigtede funktioner. Fx blev prepare_lpr3() omdøbt til
# prepare_lpr3f() i osdc undervejs - den slags skal ikke stå og rådne i guiden.
collect_calls <- function(expr, acc = new.env(parent = emptyenv())) {
  if (is.call(expr)) {
    head <- expr[[1]]

    if (is.symbol(head)) {
      acc[[as.character(head)]] <- ""
    } else if (is.call(head) && length(head) == 3 && is.symbol(head[[1]]) &&
      as.character(head[[1]]) %in% c("::", ":::")) {
      # pkg::fn() - gem som "pkg::fn"
      acc[[paste0(as.character(head[[2]]), "::", as.character(head[[3]]))]] <- ""
    }

    for (i in seq_along(expr)) {
      if (i == 1 && is.symbol(expr[[1]])) next
      # Et tomt argument (fx komma-pladsen i df[, 1]) er R_MissingArg og
      # sprænger enhver berøring. Derfor tryCatch omkring BRUGEN, ikke udtrækket.
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
      # is.symbol() først: e[[1]] kan selv være et kald (fx f(x)(y)), og så giver
      # as.character() en vektor, som && ikke vil vide af.
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
  header("2. Findes de funktioner, vi kalder?")

  # Operatorer og kontrolstrukturer, der ikke er "funktioner" i den forstand.
  syntax <- c(
    "<-", "<<-", "=", "==", "!=", "<", ">", "<=", ">=", "+", "-", "*", "/", "^",
    "!", "&", "&&", "|", "||", "~", ":", "::", ":::", "$", "@", "[", "[[", "(",
    "{", "if", "for", "while", "repeat", "function", "return", "break", "next",
    "%>%", "%in%", "%%", "%/%", "%||%", "...", "\\"
  )

  # Basispakker er altid tilgængelige uden library().
  base_pkgs <- c("base", "stats", "utils", "methods", "graphics", "grDevices", "datasets", "tools")
  known_base <- unlist(lapply(base_pkgs, function(p) ls(getNamespace(p))), use.names = FALSE)

  # Hvilke pakker nævner guiden overhovedet? (library(x), require(x), x::y)
  mentioned <- character()
  for (f in qmd_files()) {
    txt <- paste(readLines(f, warn = FALSE), collapse = "\n")
    mentioned <- c(
      mentioned,
      gsub('.*\\(["\']?|["\']?\\).*', "", regmatches(txt, gregexpr('(?:library|require)\\(["\']?[A-Za-z0-9._]+["\']?\\)', txt))[[1]]),
      sub("::.*", "", regmatches(txt, gregexpr("[A-Za-z][A-Za-z0-9._]*::", txt))[[1]])
    )
  }
  # Pladsholdere fra prosa-eksempler som library(pakke) er ikke rigtige pakker.
  placeholders <- c("pakke", "pakkenavn", "package", "packagename", "dinpakke")
  mentioned <- setdiff(unique(gsub("[^A-Za-z0-9._]", "", mentioned)), c("", base_pkgs, placeholders))

  installed <- rownames(installed.packages())
  usable <- intersect(mentioned, installed)
  missing_pkgs <- setdiff(mentioned, installed)

  # Hvilken pakke eksporterer hvilken funktion? Bruges til at sige "du kalder
  # CreateTableOne(), men du indlæser aldrig tableone".
  exporter <- list()
  for (p in usable) {
    for (fn in tryCatch(getNamespaceExports(p), error = function(e) character())) {
      if (is.null(exporter[[fn]])) exporter[[fn]] <- p
    }
  }

  # library(tidyverse) giver adgang til kernepakkerne uden at nævne dem.
  tidyverse_core <- c(
    "dplyr", "ggplot2", "tidyr", "readr", "purrr", "tibble",
    "stringr", "forcats", "lubridate"
  )

  # Eksporter for EN liste af pakker (bruges per side, ikke globalt).
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

  # "Ambient"-pakker: forudsat indlæst overalt, så de kræver ikke en library()-linje
  # i hvert eneste uddrag. Se .config/ambient-packages.txt for begrundelsen.
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

    # Hvilke pakker læner DENNE side sig op ad, og mangler nogen af dem lokalt?
    # Hvis ja, kan vi ikke afgøre om et ukendt kald er en fejl eller bare en
    # funktion fra en pakke, vi ikke har. Så er det støj, ikke et fund.
    file_pkgs <- gsub(
      '.*\\(["\']?|["\']?\\).*', "",
      regmatches(txt, gregexpr('(?:library|require)\\(["\']?[A-Za-z0-9._]+["\']?\\)', txt))[[1]]
    )
    file_pkgs <- setdiff(unique(gsub("[^A-Za-z0-9._]", "", file_pkgs)), c("", base_pkgs, placeholders))
    unresolvable <- setdiff(file_pkgs, installed)

    # Kendt PÅ DENNE SIDE = base + de pakker siden SELV indlæser + det, siden selv
    # definerer + allowlisten. Bevidst IKKE pakker, en helt anden side tilfældigvis
    # indlæser: en læser lander på én side og kører dens kode, ikke hele sitets.
    file_known <- c(known_base, exports_of(file_pkgs), locally_defined(exprs))

    acc <- new.env(parent = emptyenv())
    for (e in exprs) collect_calls(e, acc)
    calls <- ls(acc)

    # pkg::fn - her VED vi hvilken pakke der menes, så det er et hårdt tjek.
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
        fail(rel(f), " - ", q, "() findes IKKE i ", pkg, ". Omdøbt eller opdigtet?")
      }
    }

    unknown <- setdiff(plain, file_known)
    if (!length(unknown)) next

    # Findes funktionen i en installeret pakke, som siden bare aldrig indlæser?
    # Så er det ikke en opdigtet funktion, men en manglende library()-linje - og
    # læseren får "could not find function" på første kørsel.
    undeclared <- unknown[!vapply(unknown, function(x) is.null(exporter[[x]]), logical(1))]
    genuinely_unknown <- setdiff(unknown, undeclared)

    for (x in undeclared) {
      n_undeclared <- n_undeclared + 1L
      warn(rel(f), " - kalder ", x, "(), men indlæser aldrig library(", exporter[[x]], ")")
    }

    if (!length(genuinely_unknown)) next

    if (length(unresolvable)) {
      # Siden bruger pakker, vi ikke har installeret. Kan ikke afgøres.
      n_unverifiable <- n_unverifiable + length(genuinely_unknown)
    } else {
      # Alle sidens pakker er installeret, og funktionen findes stadig ingen steder.
      n_unknown <- n_unknown + length(genuinely_unknown)
      warn(rel(f), " - ukendte funktioner: ", paste(sort(genuinely_unknown), collapse = ", "))
    }
  }

  cat("Installeret og verificeret: ", paste(sort(usable), collapse = ", "), "\n\n", sep = "")
  if (length(missing_pkgs)) {
    cat(
      "IKKE installeret lokalt (", length(missing_pkgs), " pakker), så ", n_unverifiable,
      " kald kan ikke verificeres:\n  ",
      paste(sort(missing_pkgs), collapse = ", "), "\n",
      "Installér dem for fuld dækning - især osdc og fastreg, som guiden læner sig tungt op ad.\n\n",
      sep = ""
    )
  }
  cat(n_undeclared, " kald bruger en pakke, siden aldrig indlæser (manglende library()).\n", sep = "")
  cat(n_unknown, " kald ser ud til at være reelt forkerte.\n", sep = "")
}

#-----------------------------------------------------
# 3. parity - har da/ og en/ samme struktur?
#-----------------------------------------------------
# 161.000 ord holdt i spejl i hånden. Det driver fra hinanden, og det skal
# opdages den dag det sker, ikke et halvt år efter.
PAIR_EXCEPTIONS <- c(
  "00_index.qmd" = "index.qmd",
  "bidrag.qmd" = "contribute.qmd"
)

check_parity <- function() {
  header("3. Er da/ og en/ strukturelt ens?")

  da <- basename(list.files(file.path(ROOT, "da"), pattern = "\\.qmd$"))
  en <- basename(list.files(file.path(ROOT, "en"), pattern = "\\.qmd$"))

  counts <- function(path) {
    lines <- readLines(path, warn = FALSE)
    prose <- prose_lines(lines)
    blocks <- extract_blocks(lines)
    c(
      fences = length(blocks),
      r_blocks = sum(vapply(blocks, function(b) is_r_block(b$info), logical(1))),
      headings = sum(grepl("^#{1,6} ", prose)),
      callouts = sum(grepl("^:::", prose)),
      table_rows = sum(grepl("^\\|", prose))
    )
  }

  n_bad <- 0L
  paired_en <- character()

  for (f in da) {
    counterpart <- if (f %in% names(PAIR_EXCEPTIONS)) PAIR_EXCEPTIONS[[f]] else f
    en_path <- file.path(ROOT, "en", counterpart)

    if (!file.exists(en_path)) {
      n_bad <- n_bad + 1L
      fail("da/", f, " har ingen engelsk modpart (forventede en/", counterpart, ")")
      next
    }
    paired_en <- c(paired_en, counterpart)

    a <- counts(file.path(ROOT, "da", f))
    b <- counts(en_path)
    diff <- names(a)[a != b]

    if (length(diff)) {
      n_bad <- n_bad + 1L
      detail <- paste0(diff, ": da=", a[diff], " en=", b[diff], collapse = ", ")
      fail("da/", f, " vs en/", counterpart, " - strukturen matcher ikke (", detail, ")")
    }
  }

  # Engelske sider uden dansk modpart.
  for (f in setdiff(en, paired_en)) {
    n_bad <- n_bad + 1L
    fail("en/", f, " har ingen dansk modpart")
  }

  cat("Sammenlignede ", length(da), " sidepar, ", n_bad, " matcher ikke.\n", sep = "")
}

#-----------------------------------------------------
# 4. style - husreglerne fra CLAUDE.md
#-----------------------------------------------------
check_style <- function() {
  header("4. Husregler (em-dash, %>%, kolon efter labels)")

  n <- 0L
  for (f in qmd_files()) {
    lines <- readLines(f, warn = FALSE)

    # Ingen em-dash (U+2014). Gælder alt indhold, begge sprog.
    hits <- grep("—", lines)
    for (i in hits) {
      n <- n + 1L
      fail(rel(f), ":", i, " - em-dash (U+2014). Brug komma, kolon, parentes eller ' - '.")
    }

    # %>% ikke |> - men KUN i faktisk R-kode. Guiden forklarer med vilje
    # forskellen på %>% og |> i prosa (02_r-intro, guide_til_funktioner), og
    # den slags omtale er ikke et stilbrud.
    for (b in extract_blocks(lines)) {
      if (!is_r_block(b$info)) next
      hits <- grep("|>", b$code, fixed = TRUE)
      for (h in hits) {
        n <- n + 1L
        fail(rel(f), ":", b$start + h, " - native pipe |> i kode. Guiden bruger %>%.")
      }
    }

    # Kolon (ikke " - ") efter en fed eller linket label i et listepunkt.
    prose <- prose_lines(lines)
    bad_label <- grep("^\\s*[-*] (\\*\\*[^*]+\\*\\*|\\[[^]]+\\]\\([^)]*\\)) - ", prose, value = TRUE)
    for (b in bad_label) {
      n <- n + 1L
      warn(rel(f), " - listepunkt bruger ' - ' efter label, skal være kolon: ", substr(trimws(b), 1, 60), "...")
    }
  }

  cat(n, " stilbrud fundet.\n", sep = "")
}

#-----------------------------------------------------
# Kør
#-----------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
what <- if (length(args)) args[1] else "all"

if (what %in% c("all", "code")) check_code()
if (what %in% c("all", "functions")) check_functions()
if (what %in% c("all", "parity")) check_parity()
if (what %in% c("all", "style")) check_style()

header("Resultat")

if (length(FINDINGS$warnings)) {
  cat("\nADVARSLER (", length(FINDINGS$warnings), "):\n", sep = "")
  cat(paste0("  ! ", FINDINGS$warnings, collapse = "\n"), "\n", sep = "")
}

if (length(FINDINGS$errors)) {
  cat("\nFEJL (", length(FINDINGS$errors), "):\n", sep = "")
  cat(paste0("  x ", FINDINGS$errors, collapse = "\n"), "\n", sep = "")
  cat("\nHusk også: just check-urls (døde links) og just check-spelling.\n")
  quit(status = 1)
}

cat("\nAlt OK. Husk også: just check-urls (døde links) og just check-spelling.\n")
