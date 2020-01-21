#' @import shiny
app_server <- function(input, output,session) {
  
  # Data --------------------------------------------------------------------
  
  # Why shouldnt this just go straight into the map module?
  # world <- ggplot2::map_data("world")
  # world <- world %>% dplyr::left_join(ffd_indicators, by = c("region" = "reporter"))
  # countries <- data("countries")
  
  
  # List the first level callModules here
  country <- callModule(mod_country_select_server, "country_select_ui_1")
  # country <- callModule(mod_test_server, "test_ui_1")
  callModule(mod_country_map_server, "country_map_ui_1", country = country)
  callModule(mod_country_flag_server, "country_flag_ui_1", dataset = countries, country = country)
}
