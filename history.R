rrtools::use_compendium("../datatoolboxexos", open=FALSE) #create the compendium
usethis::use_r("data_wildfinder") #create an r file
usethis::use_package("here")
usethis::use_package("readr")
rrtools::use_readme_rmd() #create a readme file
devtools::install_deps() ##installe tous package dans imports et dependencies du fichier description
devtools::document() ##créé la documentation à partir des trucs roxygen de nos fonctions, créé dossier man
#quand je fais ca, me demande d'écraser le fichier description et supprime le contenu du fichier data_wildfinder où y a les fonctions
devtools::load_all() #rend toutes les fonctions disponibles mais ne les place pas dans l'environnement de travail comme avec source
#donc là c'est bon on peut accéder aux fonctions via datatoolbox::fonction()
