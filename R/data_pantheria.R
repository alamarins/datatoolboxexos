#' Get pantheria data
#'
#' @return data.frame with infos on pantheria
#' @export
#'
data_pantheria <- function() {

  readr::read_delim(here::here("data","pantheria-traits","PanTHERIA_1-0_WR05_Aug2008.txt"), delim="\t")

}

#' Extract ursidae
#'
#' @param spdata The data containing all species
#'
#' @return A tibble only containing ursidae
#' @export
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom magrittr %>%
#'
#' @examples
extract_ursidae <- function(spdata) {
  spdata %>%
    dplyr::filter(family   == "Ursidae") %>%        # Sélection des Ursidés
    dplyr::filter(sci_name != "Ursus malayanus") %>%    # Suppression du synonyme
    dplyr::select(sci_name, family, common, species_id)          # Sélection de colonnes

}

#' Join dataframes
#'
#' @param data_ursus The data containing ursidae species
#' @param data_speco The data containing species and ecoregions
#' @param data_eco   The data containing ecoregion info
#'
#' @return A tibble containing ursidae with ecoregion info
#' @export
#' @importFrom dplyr left_join
#' @importFrom magrittr %>%
#'
#' @examples
join <- function(ursus_data, sp_eco_data ,eco_data) {
  ursus_data %>% dplyr::left_join(sp_eco_data, by="species_id") %>%
    dplyr::left_join(eco_data, by="ecoregion_id")
}

#' Get number of ecoregions
#'
#' @param data The joined tibble containing Ursidae species and ecoregion info
#'
#' @return A tibble with number of ecoregions per species of family Ursidae
#' @export
#' @importFrom dplyr group_by
#' @importFrom dplyr n_distinct
#' @importFrom dplyr summarise
#' @importFrom magrittr %>%
#' @importFrom dplyr arrange
#'
#' @examples
get_necoregions <- function(ursus_eco_joined) {
  ursus_eco_joined %>%
    dplyr::group_by(sci_name) %>%
    dplyr::summarise(n_ecoregions = dplyr::n_distinct(ecoregion)) %>%
    dplyr::arrange(dplyr::desc(n_ecoregions))
}


#' Tidy data pantheria
#'
#' @param data The raw pantheria dataset
#'
#' @return A cleaned tibble
#' @export
#' @importFrom dplyr mutate
#' @importFrom dplyr rename
#' @importFrom dplyr select
#' @importFrom dplyr na_if
#' @importFrom forcats as_factor
#' @importFrom magrittr %>%
#'
#' @examples
tidy_pantheria <- function(data) {
  data %>%
    dplyr::mutate(                                    # Conversion de type
      order   = forcats::as_factor(MSW05_Order),
      family  = forcats::as_factor(MSW05_Family)
    ) %>%
    dplyr::rename(                                    # Nom des colonnes
      adult_bodymass = `5-1_AdultBodyMass_g`,
      dispersal_age  = `7-1_DispersalAge_d`,
      gestation      = `9-1_GestationLen_d`,
      homerange      = `22-2_HomeRange_Indiv_km2`,
      litter_size    = `16-1_LittersPerYear`,
      longevity      = `17-1_MaxLongevity_m`
    ) %>%
    dplyr::select(                                    # Sélection de colonnes
      order,
      family,
      adult_bodymass,
      dispersal_age,
      gestation,
      homerange,
      litter_size,
      longevity
    ) %>%
    dplyr::na_if(-999)
}
