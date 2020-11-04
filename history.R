rrtools::use_compendium("../datatoolboxexos", open=FALSE) #create the compendium
usethis::use_r("data_wildfinder") #create an r file where you write all your functions
usethis::use_package("here")
usethis::use_package("readr")
rrtools::use_readme_rmd() #create a readme file
devtools::install_deps() ##installe tous package dans imports et dependencies du fichier description
devtools::document() ##créé la documentation à partir des trucs roxygen de nos fonctions, créé dossier man
#quand je fais ca, me demande d'écraser le fichier description et supprime le contenu du fichier data_wildfinder où y a les fonctions
devtools::load_all() #rend toutes les fonctions disponibles mais ne les place pas dans l'environnement de travail comme avec source
#donc là c'est bon on peut accéder aux fonctions via datatoolbox::fonction()
?datatoolboxexos::data_ecoregion() #on a bien créé l'aide

#commence exo 2
usethis::use_pipe(export=TRUE) #à cause de l'exo 2 ggplot, besoin du pipe mais veut le faire sans charger library tidyverse
#rend la fonction écrite dans le dossier R
#a rajouté magrittr dans liste des imports dans doc description
devtools::document() #regénère la doc du coup
usethis::use_r("data_pantheria") #to write the function to read the data pantheria
devtools::load_all()
devtools::document()


#exo drake
usethis::use_r(name = "plan.R")
file.create("_drake.R")
#file.create("make.R") eesayons de modifier celui que l'on a déjà
dir.create("output")
#dir.create("text") #on peut aussi utliser notre répertoire "exercices" ici ;)
dir.create("output/plots")
dir.create("output/text")
# add needed packages
usethis::use_package("dplyr")
usethis::use_package("ggplot2")
usethis::use_package("magrittr")
usethis::use_package("forcats")
usethis::use_package("fishualize")
usethis::use_package("sf")
usethis::use_package("drake")
# ignore files
usethis::use_build_ignore(".drake")
usethis::use_build_ignore("_drake.R")
usethis::use_build_ignore("make.R")
usethis::use_git_ignore(".drake")
usethis::use_build_ignore("output/")
usethis::use_build_ignore("text/")
