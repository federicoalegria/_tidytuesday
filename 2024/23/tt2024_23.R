# --- TIDYTUESDAY::2024§23 --- #

# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-06-04/readme.md

# Load ----

# packages ----
pacman::p_load(
  countrycode,
  data.table,
  ggalluvial,
  ggthemes,
  janitor,
  skimr,
  tidyverse
)

# data ----
df <-
  fread(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2024/2024-06-04/cheeses.csv'
  ) |>
  clean_names()
# dictionary
# https://t.ly/XRWHS

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

# Visualise ----

# sankey ----
## https://corybrunson.github.io/ggalluvial/articles/ggalluvial.html

# ensure categorical axis

## continents
custom_mapping <- c(
  "England" = "Europe",
  "Middle East" = "Asia",
  "Scotland" = "Europe",
  "Wales" = "Europe"
)

# df |>
#   mutate(country = str_extract(country, "^[^,]+")) |>
#   mutate(continent = recode(
#     country,
#     !!!custom_mapping,     # *
#     .default = countrycode(country, "country.name", "continent")
#     )
# )
## * splices the named vector so that each element is treated as an individual 
## argument in the recode() function
## https://rdrr.io/github/tidyverse/rlang/f/man/rmd/topic-metaprogramming.Rmd

## continent_milk_rind
df |>
  mutate(country = str_extract(country, "^[^,]+")) |>
  mutate(continent = recode(
    country,!!!custom_mapping,
    .default = countrycode(country, "country.name", "continent")
  )) |>
  mutate(milk = str_extract(milk, "^[^,]+")) |>
  filter(continent != "Africa") |> 
  filter(!milk %in% c("cow", "plant-based")) |>
  filter(!rind %in% c("artificial", "cloth wrapped", "edible", "plastic")) |>
  mutate(non_vegan = as.numeric(!vegan)) |>
  drop_na(continent, milk, rind, non_vegan) |>
  ggplot(aes(
    axis1 = continent,
    axis2 = milk,
    axis3 = rind,
    y = non_vegan
  )) +
  geom_alluvium(aes(fill = milk), alpha = 0.9, width = 1 / 12) +
  geom_stratum(alpha = .15,
               width = 1.5 / 12,
               fill = "#ebdbb2",
               color = "#20111b") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("continent", "milk", "rind")) +
  scale_fill_manual(
    values = c(
      "buffalo" = "#be100e",
      "goat" = "#a89984",
      "sheep" = "#d79921",
      "water buffalo" = "#426a79"
    )
  ) +
  theme_wsj(base_family = 'Consolas', color = '#ebdbb2') +
  theme(
    axis.text.y = element_blank(),
    legend.text = element_text(family = 'Consolas'),
    legend.title = element_blank(),
    plot.caption = element_text(size = 9),
    plot.subtitle = element_text(size = 18),
    plot.title = element_text(family = 'Consolas', face = 'bold', size = 23),
    text = element_text(family = 'Consolas')
  ) +
  labs(title = "cheese", 
       subtitle = "continent, animal source and rind",
       caption = "camel, cow and plant-based milk were excluded from this plot
       data pulled from https://t.ly/XRWHS by https://github.com/federicoalegria",
       x = " ",
       y = " ")

# Communicate ----

# for #tidytuesday 2024§23, i explored cheese in a stretchy way: 
# https://github.com/federicoalegria/_tidytuesday/blob/main/2024/23/tt2024_23.R
