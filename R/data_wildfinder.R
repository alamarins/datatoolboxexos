
#' Get ecoregion data
#'
#' @return data.frame with infos on ecoregions
#' @export
#'
data_ecoregion <- function() {

  readr::read_csv(here::here("data","wwf-wildfinder","wildfinder-ecoregions_list.csv"))

}

#' Get mammal species data
#'
#' @return data.frame with infos on species
#' @export
#'
data_mammals <- function() {

  readr::read_csv(here::here("data","wwf-wildfinder","wildfinder-mammals_list.csv"))

}

#' Get mammal species <-> ecoregions data
#'
#' @return data.frame with infos on which mammals in ecoregions
#' @export
#'
data_ecoregions_mammals <- function() {

  readr::read_csv(here::here("data","wwf-wildfinder","wildfinder-ecoregions_species.csv"))

}
