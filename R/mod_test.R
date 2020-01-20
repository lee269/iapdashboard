# Module UI
  
#' @title   mod_test_ui and mod_test_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_test
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_test_ui <- function(id){
  ns <- NS(id)
  tagList(
  textOutput(outputId = "countrytext")
  )
}
    
# Module Server
    
#' @rdname mod_test
#' @export
#' @keywords internal
    
mod_test_server <- function(input, output, session, country){
  ns <- session$ns
  output$countreytext = renderText(country$country())
}
    
## To be copied in the UI
# mod_test_ui("test_ui_1")
    
## To be copied in the server
# callModule(mod_test_server, "test_ui_1")
 
