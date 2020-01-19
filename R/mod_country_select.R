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
#' @rdname mod_country_select
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_country_select_ui <- function(id, data, label = "Select country:"){
  ns <- NS(id)
  
  # https://rpodcast.shinyapps.io/modules_article1/
  countries <- data %>% 
    dplyr::ungroup() %>% 
    dplyr::select(reporter, reporter_iso) %>% 
    tibble::deframe()
  
  tagList(
    selectInput(inputId = ns("country"), label = label, choices = countries)
  )
}
    
# Module Server
    
#' @rdname mod_country_select
#' @export
#' @keywords internal
    
mod_country_select_server <- function(input, output, session){
  ns <- session$ns
  return(list(country = reactive(input$country)))
}
    
## To be copied in the UI
# mod_country_select_ui("country_select_ui_1")
    
## To be copied in the server
# callModule(mod_country_select_server, "country_select_ui_1")
 
