#-----------------------------------------------------------------------------
# dst-checks.R - hand-written section for the code bundle.
#-----------------------------------------------------------------------------
# Everything in this file is copied verbatim into dst_code_examples.R as the
# FIRST section, so it becomes 00_check_your_project.R after the splitter.
#
# It is NOT extracted from a .qmd page - edit it here.
#
# Purpose: the guide states a number of things about the registers that are
# confirmed on one project and one date. This script checks them against YOUR
# data, so you find out before an analysis does. Everything below is read-only.
#-----------------------------------------------------------------------------

# CHECK YOUR PROJECT - run this before you trust the guide's examples
#
# The guide's register details were confirmed on DARTER (project 708421) in
# 2026. Column names, register structures and file locations differ between
# projects and change over time. Each check below prints an answer and changes
# nothing. Run the whole file, or pick the checks that matter to you.
#
# Anything that comes out unexpected: write it down, and treat the guide's
# example for that register as unverified for your project.

library(dplyr)
library(fastreg) # read_register(); without it, use open_dataset() and full paths

cat("\n=== 1. Packages and versions ===\n")

# duckplyr >= 1.1 is needed for the patterns in the guide, and the version
# pre-installed on DST is older than that. It reverts after every server reset.
for (p in c("duckplyr", "duckdb", "arrow", "fastreg", "heaven", "osdc")) {
  v <- tryCatch(as.character(packageVersion(p)), error = function(e) "NOT INSTALLED")
  cat(sprintf("  %-10s %s\n", p, v))
}

# read_parquet_duckdb() is the newer, lower-memory way to open a parquet folder.
# It only exists in recent duckplyr.
cat("  read_parquet_duckdb available:",
    "read_parquet_duckdb" %in% getNamespaceExports("duckplyr"), "\n")

# Not pre-installed anywhere - available() tells you whether you could install it
cat("  osdc installable from CRAN:", "osdc" %in% rownames(available.packages()), "\n")

cat("\n=== 2. FAIK - one row per family, or one per family member? ===\n")

# The guide's income recipe joins BEF -> FAIK on familie_id, which assumes ONE
# row per family per year. On DARTER that stopped being true from 2022: FAIK
# also carries pnr, and the row is repeated per family member. Joining on
# familie_id then multiplies your rows with no error.
faik <- read_register("faik") %>% rename_with(tolower)

cat("  has a pnr column:", "pnr" %in% colnames(faik), "\n")

faik_dupes <- faik %>%
  count(familie_id, aar) %>%
  filter(n > 1) %>%
  count() %>%
  collect()
cat("  family-years with more than one row:", faik_dupes$n, "\n")
cat("  -> if that number is above 0, add distinct(familie_id, aar, famaekvivadisp_13)\n")
cat("     before the join, or join on pnr directly.\n")

cat("\n=== 3. hfaudd - how wrong is the substr() rule on YOUR data? ===\n")

# hfaudd is a four-digit DISCED-15 code for the SPECIFIC education. Its first
# two digits are NOT the education level. Reading them anyway is right for about
# 58% of the codes - this checks how many PEOPLE that would misclassify in your
# cohort, which is the number that actually matters.
#
# Needs heaven for the lookup: pak::pak("tagteam/heaven") outside DST.
if (requireNamespace("heaven", quietly = TRUE)) {
  data(edu_code, package = "heaven")

  udda <- read_register("udda") %>%
    rename_with(tolower) %>%
    select(pnr, aar, hfaudd) %>%
    collect() %>%
    mutate(hfaudd = as.character(hfaudd))

  lookup <- as_tibble(edu_code) %>%
    mutate(hfaudd = as.character(hfaudd)) %>%
    select(hfaudd, level_code = number)

  group_level <- function(x) {
    x <- as.numeric(x)
    case_when(
      x %in% c(5, 10, 15) ~ "Short",
      x %in% c(20, 25, 29, 30, 35, 39) ~ "Medium",
      x >= 40 & x < 90 ~ "Long",
      TRUE ~ "Unknown"
    )
  }

  compare <- udda %>%
    left_join(lookup, by = "hfaudd") %>%
    mutate(
      from_lookup = group_level(level_code),
      # the old, wrong rule - kept here only to measure it
      from_digits = case_when(
        substr(hfaudd, 1, 2) %in% c("10", "15") ~ "Short",
        substr(hfaudd, 1, 2) %in% c("20", "30", "35") ~ "Medium",
        suppressWarnings(as.numeric(substr(hfaudd, 1, 2))) >= 40 ~ "Long",
        TRUE ~ "Unknown"
      )
    )

  cat("  rows with no match in edu_code:", sum(is.na(compare$level_code)), "\n")
  cat("  rows where the two disagree:",
      sum(compare$from_lookup != compare$from_digits), "of", nrow(compare),
      sprintf("(%.1f%%)\n",
              100 * mean(compare$from_lookup != compare$from_digits)))
  cat("\n  digits (rows) vs lookup (columns):\n")
  print(table(compare$from_digits, compare$from_lookup))
} else {
  cat("  heaven not available - skipped. Install with pak::pak('tagteam/heaven')\n")
}

cat("\n=== 4. LPR3 procedures - which table do you have? ===\n")

# The guide documents procedurer_kirurgi, whose dw_ek_kontakt is NA for every
# row on DARTER, so the join to lpr_a_kontakt has to go via dw_ek_forloeb -
# which also has many NA. lpr_a_procregistrering is the general table and is
# reported to have a usable dw_ek_kontakt. This checks which you have.
for (tbl in c("procedurer_kirurgi", "lpr_a_procregistrering")) {
  res <- tryCatch({
    d <- read_register(tbl) %>% rename_with(tolower)
    cat("  ", tbl, "- columns:", paste(colnames(d), collapse = ", "), "\n")
    if ("dw_ek_kontakt" %in% colnames(d)) {
      s <- d %>%
        summarise(rows = n(), missing_key = sum(is.na(dw_ek_kontakt))) %>%
        collect()
      cat("      rows:", s$rows, " missing dw_ek_kontakt:", s$missing_key,
          sprintf("(%.1f%%)\n", 100 * s$missing_key / s$rows))
    }
    TRUE
  }, error = function(e) {
    cat("  ", tbl, "- not found on this project\n")
    FALSE
  })
}

cat("\n=== 5. Deaths - does dodsaars stop around 2001? ===\n")

# dodsaars covers only ~1970-2001 on some projects. Deaths after that sit in a
# separate register (DOD), where the date column is doddato, not d_dodsdto.
# Run on dodsaars only and everyone who died after 2001 looks alive.
dodsaars <- read_register("dodsaars") %>% rename_with(tolower)
cat("  latest death date in dodsaars:\n")
dodsaars %>%
  summarise(latest = max(d_dodsdto, na.rm = TRUE)) %>%
  collect() %>%
  print()

# On DARTER the post-2001 register is readable straight from rawdata. Adjust the
# path for your own project - ask your data manager where it lives.
dod_path <- "E:/rawdata/708421/Grunddata/dod2024.sas7bdat"
cat("  DOD raw file exists at the DARTER path:", file.exists(dod_path), "\n")
if (file.exists(dod_path)) {
  dod <- haven::read_sas(dod_path)
  cat("  DOD columns:", paste(names(dod), collapse = ", "), "\n")
  cat("  -> the date column should be doddato; rename it to d_dodsdto before stacking\n")
}

cat("\n=== 6. BEF - one row per person per year? ===\n")

# The guide's panel joins assume (pnr, aar) is unique in BEF. Duplicates there
# multiply rows in every join that uses the year as a key.
bef <- read_register("bef") %>% rename_with(tolower)
bef_dupes <- bef %>%
  count(pnr, aar) %>%
  filter(n > 1) %>%
  count() %>%
  collect()
cat("  person-years with more than one row:", bef_dupes$n, "\n")

# The DARTER team moved 2002 data into the 2012 folder between 2026-07-07 and
# 2026-08-13. If you built anything in that window, check the year distribution
# looks sane before reusing it.
cat("  rows per year (eyeball for a year that is far too large):\n")
bef %>% count(aar) %>% arrange(aar) %>% collect() %>% print(n = 100)

cat("\n=== 7. osdc - the claims in the run-it-yourself script ===\n")

# These back the "Complete script" section. They only matter if you run the
# algorithm yourself rather than using a pre-computed population.
if (requireNamespace("osdc", quietly = TRUE)) {
  library(osdc)

  # (a) registers() must expose name + data_type for the type check to work
  cat("  registers()[['bef']]$variables columns:",
      paste(names(osdc::registers()[["bef"]]$variables), collapse = ", "), "\n")

  # (b) the algorithm list must have the element names the guide uses
  cat("  algorithm() elements:", paste(names(osdc::algorithm()), collapse = ", "), "\n")
  cat("  is_gld_code logic:", osdc::algorithm()$is_gld_code$logic, "\n")

  # (c) the assignInNamespace override only works while the internals look the
  #     rules up live. If a call site starts passing its own algorithm object,
  #     the override stops working silently.
  cat("\n  keep_gld_purchases - look for logic_as_expression() with NO algorithm argument:\n")
  print(osdc:::keep_gld_purchases)

  # (d) classify_diabetes() output columns, and whether has_t2d == !has_t1d.
  #     Run these two AFTER you have a diabetes object:
  #       names(diabetes)
  #       table(diabetes$has_t1d, diabetes$has_t2d)  # zeros on the diagonal
  cat("\n  run names(diabetes) and table(has_t1d, has_t2d) after classify_diabetes()\n")
} else {
  cat("  osdc not installed - install.packages('osdc') first\n")
}

cat("\n=== 8. LPR3 duplicate filter ===\n")

# lpr_a_kontakt also holds 2017-2018 contacts that are already in LPR2. Without
# the filter the same contacts are counted twice. The column sits on the CONTACT
# table, not on the diagnosis table.
lpr3_k <- read_register("lpr_a_kontakt") %>% rename_with(tolower)
cat("  lprindberetningssystem on lpr_a_kontakt:",
    "lprindberetningssystem" %in% colnames(lpr3_k), "\n")
lpr3_k %>% count(lprindberetningssystem) %>% collect() %>% print()

lpr3_d <- read_register("lpr_a_diagnose") %>% rename_with(tolower)
cat("  lprindberetningssystem on lpr_a_diagnose:",
    "lprindberetningssystem" %in% colnames(lpr3_d),
    "  <- expected FALSE; filter the CONTACT table\n")

cat("\n=== done ===\n")
cat("Anything unexpected above means the guide's example for that register\n")
cat("needs checking before you rely on it.\n")
