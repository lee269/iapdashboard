# Module UI
  
#' @title   mod_country_select_ui and mod_country_select_server
#' @description  A shiny Module.
#'
#' @param id shiny id, see \code{shiny::\link[shiny]{NS}} 
#' @param input internal
#' @param output internal
#' @param session internal
#' @param data, dataset containing reporter and reporter_iso codes
#' @param label, text label for the input box
#' 
#' @return a reactive containing an ISO3 country code
#'
#' @rdname mod_country_select
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @importFrom rlang .data
mod_country_select_ui <- function(id){
  ns <- NS(id)

    countries <- iapdashboard::country_codes %>% 
    dplyr::select(.data$country, .data$country_iso3) %>% 
    tibble::deframe()
  
  tagList(
    selectInput(inputId = ns("country"), label = "Choose country:", choices = countries)
  )
}
    
# Module Server
    
#' @rdname mod_country_select
#' @export
#' @keywords internal
    
mod_country_select_server <- function(input, output, session){
  ns <- session$ns
  output$countrytext = renderText(input$country)
}
    
## To be copied in the UI
# mod_country_select_ui("country_select_ui_1")
    
## To be copied in the server
# callModule(mod_country_select_server, "country_select_ui_1")
 
