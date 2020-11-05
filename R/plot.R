#' Plot gestation
#'
#' @param plot ggplot2 object
#' @param name character
#' @param width
#' @param height
#' @param ext png, pdf, tiff,... (default is png)
#' @param ...
#'
#' @return
#' @export
#' @import ggplot2 ggsave
#'
#' @examples
#'
save_plot <- function(plot, name, ext = "png",
                      width = 8, height = 6,
                      ...) {
  ggplot2::ggsave(plot = plot,
                  filename = here::here("output", "plots", paste0(name, ".", ext)),
                  width = width,
                  height = height,
                  ...)
}

#' Plot number of ecoregions
#'
#' @param data
#'
#' @return
#' @export
#' @import ggplot2
#' @importFrom fishualize scale_fill_fish_d
#'
#' @examples
plot_necoregions <- function(data) {
  data %>%
    ggplot2::ggplot() +
    ggplot2::aes(x = forcats::fct_reorder(sci_name, n_ecoregions),
        y = n_ecoregions, fill = forcats::fct_reorder(sci_name, n_ecoregions)) + # order bars
    ggplot2::geom_col() +
    ggplot2::coord_flip() + # flip the bar chart
    fishualize::scale_fill_fish_d(option = "Hypsypops_rubicundus") +
    ggplot2::xlab("Species") + # add label for X axis
    ggplot2::ylab("Counts") + # add label for Y axis
    ggplot2::ggtitle("Number of ecoregions per species") + # title
    ggplot2::theme_bw() +
    ggplot2::theme(legend.position = "none") # no legend
}

#' Plot gestation
#'
#' @param data
#'
#' @return
#' @export
#' @import ggplot2
#' @importFrom fishualize scale_color_fish
#'
#' @examples
plot_gestation <- function(data){
  plot <-
    data %>%
    ggplot2::ggplot() +
    ggplot2::aes(x = longevity, y = gestation, color = adult_bodymass) +
    ggplot2::geom_point(size = 5) +
    fishualize::scale_color_fish(option = "Synchiropus_splendidus", direction = -1, trans = "log") +
    ggplot2::geom_smooth(ggplot2::aes(x = longevity, y = gestation), color = "grey", se = FALSE, method = "gam") +
    ggplot2::theme_bw()
  return(plot)
}




#' Make worldmap Ursidae
#'
#' @param ursus_eco
#'
#' @return
#' @export
#'
#' @import sf
#' @import ggplot2
#' @import rnaturalearth
#'
#' @examples
get_worldmap <- function(ursus_eco){

  world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")

  terr <- sf::read_sf(here::here("data","wwf-ecoregions-layers","wwf_terr_ecos.shp")) %>%
    dplyr::rename(ecoregion = ECO_NAME) %>%
    dplyr::inner_join(ursus_eco)

  plot <-
    ggplot2::ggplot(terr) +
    ggplot2::geom_sf(data = world) +
    ggplot2::geom_sf(ggplot2::aes(fill = sci_name, color = sci_name)) +
    ggplot2::facet_wrap(~sci_name) +
    fishualize::scale_fill_fish_d(option = "Hypsypops_rubicundus") +
    fishualize::scale_color_fish_d(option = "Hypsypops_rubicundus") +
    coord_sf() +
    ggplot2::theme_minimal()

  return(plot)
}
