#' Write basic plan (la recette, avec les fonctions qui donnent des target)
#'
#' @return A drake plan
#' @export
#'
#' @importFrom drake drake_plan
#' @examples
write_plan <- function() {
  drake::drake_plan(
    eco_list = data_ecoregion(),
    sp_eco = data_ecoregions_mammals(),
    sp_list = data_mammals(),
    pantheria = data_pantheria()
  )
}

