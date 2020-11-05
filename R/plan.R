#' Write basic plan (la recette, avec les fonctions qui donnent des target)
#'
#' @return A drake plan
#' @export
#'
#' @importFrom drake drake_plan
#' @examples
write_plan <- function() {
  drake::drake_plan(
    #load data
    eco_list = data_ecoregion(),
    sp_eco = data_ecoregions_mammals(),
    sp_list = data_mammals(),
    pantheria = data_pantheria(),
    #wrangling
    ursus = extract_ursidae(sp_list),
    ursus_eco = join(ursus,sp_eco,eco_list),
    ursus_neco = get_necoregions(ursus_eco),
    pan_tidy = tidy_pantheria(pantheria)
  )
}

#' Write final plan
#'
#' @return A drake plan
#' @export
#'
#' @examples
write_plan_final <- function() {
  drake::drake_plan(
    #load data
    eco_list = data_ecoregion(),
    sp_eco = data_ecoregions_mammals(),
    sp_list = data_mammals(),
    pantheria = data_pantheria(),
    #wrangling
    ursus = extract_ursidae(sp_list),
    ursus_eco = join(ursus,sp_eco,eco_list),
    ursus_neco = get_necoregions(ursus_eco),
    pan_tidy = tidy_pantheria(pantheria),
    # figures
    fig1 = plot_necoregions(ursus_neco),
    fig2 = plot_gestation(pan_tidy),
    #fig3 = get_worldmap(ursus_eco),
    # output
    out_fig1 = save_plot(fig1, "figure1_necoregions"),
    out_fig2 = save_plot(fig2, "figure2_gestation"),
    #out_fig3 = save_plot(fig3, "figure3_worldmap"),
    # report
    report = rmarkdown::render(
      drake::knitr_in("exercices/report-drake.Rmd"),
      output_file = drake::file_out("output/text/report-drake.html"),
      quiet = FALSE,
      output_dir = "output/text/"
    )
  )
}

