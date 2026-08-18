# --- tidytuesday::2633 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-08-18/readme.md

# setup ----

# library path
.libPaths("~/.local/share/R/x86_64-pc-linux-gnu-library/4.6")

# sanity check
pak::pkg_deps_tree()
pak::pkg_outdated()

# check requirements for specific packages
pak::pkg_sysreqs("ggraph")
pak::pkg_sysreqs("tidyverse")

# check requirements for ALL outdated packages
outdated <- pak::pkg_outdated()
if (nrow(outdated) > 0) {
  pak::pkg_sysreqs(outdated$package)
}
# if pak outputs pacman -s ... commands, run them in your terminal first.

pak::pkg_update(ask = FALSE, check_installed = TRUE)

# check: pak::pkg_outdated()
# verify sysreqs: pak::pkg_sysreqs(pak::pkg_outdated()$package) → install any listed system packages via pacman
# update: pak::pkg_update(ask = false, check_installed = true)
# load: keep using pacman::p_load(...) in your scripts

# load
pacman::p_load(
  data.table, # https://cran.r-project.org/web/packages/data.table/
  janitor, # https://cran.r-project.org/web/packages/janitor/
  skimr, # https://cran.r-project.org/web/packages/skimr/
  tidytext, # https://cran.r-project.org/web/packages/tidytext/
  tidyverse # https://cran.r-project.org/web/packages/tidyverse/
)

# import
dfa <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_first_language.csv'
  ) |>
  clean_names()

dfb <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_nationality.csv'
  ) |>
  clean_names()

dfc <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/demo_by_reasons.csv'
  ) |>
  clean_names()

dfd <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_first_language.csv'
  ) |>
  clean_names()

dfe <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-18/performance_by_nationality.csv'
  ) |>
  clean_names()
# dictionary
# https://github.com/rfordatascience/tidytuesday/raw/refs/heads/main/data/2026/2026-08-18/readme.md

# understand ----

df_list <- list(dfa = dfa, dfb = dfb, dfc = dfc, dfd = dfd, dfe = dfe)

# names
df_list |>
  map(
    ~ .x |>
      slice(0) |>
      glimpse()
)

# glimpse & skim
df_list |> 
  map(
    ~.x |> 
      glimpse() |> 
      skim()
)

# visualise ----

dfd |>
  ggplot(aes(x = score)) +
  geom_density() +
  theme_minimal()

# model ----

# communicate ----

# ...

# This week we're exploring International English Language Testing System
# (IELTS) Tests statistics. The dataset comes from the IELTS research website
# and contains mean scores in various aggregations.

# IELTS is proud to offer transparent statistics on our testing system. The
# following data has been compiled from the scores achieved by various groups of
# test takers. It helps researchers and teachers understand the performance of
# the test and how test takers perform in particular countries or regions.

# The IELTS exam consists of 4 parts: Listening, Speaking, Reading and Writing.
# Each part is scored using a "band" system from 1 to 9, and then the four parts
# are averaged for an overall score. You can find more information on what each
# band means in the IELTS website. There are two versions of the exam: Academic
# and General Training. The dataset provides values for the years 2022, 2023 and
# 2024.

# Some questions you can answer:

# - Do English speakers consistently get top marks on the English language test?
# - Which parts of the test do test takers find the most difficult? Is it the
#   same for all test takers?
# - Does the reason for taking the test affect the score?
# - Has there been a change in tests scores in the three years for which we have
#   information?
