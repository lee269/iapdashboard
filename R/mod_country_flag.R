# Module UI
  
#' @title   mod_country_flag_ui and mod_country_flag_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_country_flag
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_country_flag_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_country_flag
#' @export
#' @keywords internal
    
mod_country_flag_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_country_flag_ui("country_flag_ui_1")
    
## To be copied in the server
# callModule(mod_country_flag_server, "country_flag_ui_1")
 
