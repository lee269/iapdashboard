#' @import shiny
app_server <- function(input, output,session) {
  
  # Data --------------------------------------------------------------------
  
  # Why shouldnt this just go straight into the map module?
  # world <- ggplot2::map_data("world")
  # world <- world %>% dplyr::left_join(ffd_indicators, by = c("region" = "reporter"))
  # countries <- data("countries")
  

  # List the first level callModules here
  # the country select input
  country <- callModule(mod_country_select_server, "country_select_ui_1")

  # Country map and flag section
  callModule(mod_country_map_server, "country_map_ui_1", country = country)
  callModule(mod_country_flag_server, "country_flag_ui_1", country = country)
  
  # World Bank indicator section
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_pop", country = country, indicator = reactive("SP.POP.TOTL"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_gdp", country = country, indicator = reactive("NY.GDP.PCAP.PP.KD"), format = "dollar")
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_imports", country = country, indicator = reactive("NE.IMP.GNFS.ZS"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_bus_ease", country = country, indicator = reactive("IC.BUS.EASE.XQ"))
  
  # Market overview section
  callModule(mod_ffd_indicator_table_server, "ffd_indicator_table_ui_1", country = country)
}
