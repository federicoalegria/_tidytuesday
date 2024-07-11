# --- TIDYTUESDAY::2024§28 --- #
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-07-09/readme.md

# Load ----

.libPaths(c("~/.R/x86_64-pc-linux-gnu-library/4.4", .libPaths()))

# packages ----
pacman::p_load(
  data.table,           # https://cran.r-project.org/web/packages/data.table/
  janitor,              # https://cran.r-project.org/web/packages/janitor/
  skimr,                # https://cran.r-project.org/web/packages/skimr/
  tidyverse             # https://cran.r-project.org/web/packages/tidyverse/
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-07-09/drob_funs.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/U-WWB

# Wrangle ----

# eda ----

# names
df |> 
  slice(0) |> 
  glimpse()

# glimpse & skim
df |>
  glimpse() |>
  skim()

df |> 
  group_by(pkgs) |> 
  summarise(n = n()) |> 
  arrange(desc(n))

df |> 
  select(pkgs, funs) |> 
  group_by(pkgs, funs) |> 
  summarise(n = n()) |> 
  arrange(pkgs, desc(n))

# Visualise ----

## inspiration
## https://r-graph-gallery.com/334-basic-dendrogram-with-ggraph.html

# raw ----
# rice ----

# Analyse ----

# ...

# Communicate ----

# ...