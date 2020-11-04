#!/usr/bin/env Rscript

# ----- clean workspace
rm(list = ls())

# ----- install/update packages
devtools::install_deps()

# ----- install compendium package #rend les fonctions disponibles en installant le package
devtools::install(build = FALSE)
#can also do
devtools::load_all()

# ----- Knit exo dplyr
rmarkdown::render(here::here("exercices","exo_dplyr.Rmd"))

# ----- Knit exo ggplot2
rmarkdown::render(here::here("exercices","exo2-pantheria.Rmd"))

# ----- drake
## Execute plan
drake::r_make() #relance session R, reconnait _drake et sait ce qu'il faut faire
## Visualize
drake::r_vis_drake_graph(targets_only = TRUE)
drake::r_vis_drake_graph()
