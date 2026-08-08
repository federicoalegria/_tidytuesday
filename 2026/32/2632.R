# --- tidytuesday::2632 --- #
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2026/2026-08-11/readme.md

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
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_emission_lines.csv'
  ) |>
  clean_names()

dfb <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-08-11/palomar_survey.csv'
  ) |>
  clean_names()
# dictionary
# https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2026/2026-08-11/readme.md

# understand ----

# names
dfa |> 
  slice(0) |> 
  glimpse()

dfb |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
dfa |>
  glimpse() |>
  skim()

dfb |>
  glimpse() |>
  skim()

# transform ----

# visualise ----

dfa |> 
  drop_na(h_beta, h_gamma) |>
  ggplot(aes(x = h_beta, y = h_gamma)) +
  geom_point()

# model ----

# communicate ----

# ...

# This week we're exploring spectroscopic observations of 486 nearby galaxies
# from the Palomar Spectroscopic Survey. In the 1990s, astronomers used the
# 200-inch Hale Telescope at Palomar Observatory — once the world's largest — to
# split the light from the centers of nearly 500 nearby galaxies into a rainbow
# of wavelengths. By measuring the strength of specific emission lines in those
# spectra, they classified each galaxy's nucleus as powered by young stars, by
# an active galactic nucleus (AGN), or by some combination of both.

# The dataset comes from a landmark series of papers by Ho, Filippenko & Sargent
# that quantified the demographics of nuclear activity in the local universe.
# Their key finding: roughly 43% of nearby galaxies show spectroscopic
# signatures of AGN activity, making "active" nuclei far more common than
# previously recognized. A more recent census of over 8,000 galaxies using
# similar techniques (Harvard CfA, January 2025) continues to refine these
# detection rates, confirming that the spectral classification approach
# pioneered in the Palomar survey remains foundational to the field.

# We use the sample of emission-line nuclei derived from a recently completed
# optical spectroscopic survey of nearby galaxies to quantify the incidence of
# local (z = 0) nuclear activity. [...] Half of the objects can be classified as
# H II or star-forming nuclei and the other half as some form of AGN, of which
# we distinguish three classes — Seyfert nuclei, LINERs, and transition objects.

# - What types of nuclear activity are most common, and how does that vary with
#   galaxy morphology (spirals vs. ellipticals)?

# - Can you recreate the classic BPT diagnostic diagram using the emission-line
#   ratios? Where do the different activity types fall?

# - Is there a relationship between a galaxy's velocity dispersion (a proxy for
#   central mass) and the type of nuclear activity it hosts?

# - Which galaxy morphological types are most likely to host Seyfert nuclei vs.
#   LINERs?
