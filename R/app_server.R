#' @import shiny
app_server <- function(input, output,session) {
  
  # Data --------------------------------------------------------------------
  
  # Why shouldnt this just go straight into the map module?
  # world <- ggplot2::map_data("world")
  # world <- world %>% dplyr::left_join(ffd_indicators, by = c("region" = "reporter"))
  # countries <- data("countries")
  

  # List the first level callModules here
  

# Universal items ---------------------------------------------------------

  # the country select input
  country <- callModule(mod_country_select_server, "country_select_ui_1")

  # Navbar
  callModule(mod_country_name_server, "country_name_ui_navbar", country = country)


# Home tab ----------------------------------------------------------------

  # Country map and flag section
  callModule(mod_country_map_server, "country_map_ui_home", country = country)
  callModule(mod_country_flag_server, "country_flag_ui_home", country = country, height = "100", width = "140")
  
  # World Bank indicator section
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_pop_home", country = country, indicator = reactive("SP.POP.TOTL"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_gdp_home", country = country, indicator = reactive("NY.GDP.PCAP.PP.KD"), format = "dollar")
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_imports_home", country = country, indicator = reactive("NE.IMP.GNFS.ZS"), format = "percent")
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_bus_ease_home", country = country, indicator = reactive("IC.BUS.EASE.XQ"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_food_imports_home", country = country, indicator = reactive("TM.VAL.FOOD.ZS.UN"), format = "percent")


# Details tab -------------------------------------------------------------
  
  # Country map and flag section
  callModule(mod_country_map_server, "country_map_ui_details", country = country)
  callModule(mod_country_flag_server, "country_flag_ui_details", country = country, height = "100", width = "140")
  
  # World Bank indicator section
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_pop_details", country = country, indicator = reactive("SP.POP.TOTL"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_gdp_details", country = country, indicator = reactive("NY.GDP.PCAP.PP.KD"), format = "dollar")
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_imports_details", country = country, indicator = reactive("NE.IMP.GNFS.ZS"), format = "percent")
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_bus_ease_details", country = country, indicator = reactive("IC.BUS.EASE.XQ"))
  callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_food_imports_details", country = country, indicator = reactive("TM.VAL.FOOD.ZS.UN"), format = "percent")
  
  
  
    
  # Market overview section
  callModule(mod_ffd_indicator_table_server, "ffd_indicator_table_ui_1", country = country)
  callModule(mod_ffd_indicator_series_server, "ffd_indicator_series_ui_1", country = country)
  
  # Detail section
  callModule(mod_ffd_country_series_server, "ffd_country_series_ui_1", country = country)
  callModule(mod_ffd_product_series_server, "ffd_product_series_ui_1", country = country)
  
}
