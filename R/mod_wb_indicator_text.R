# Module UI
  
#' @title   mod_wb_indicator_text_ui and mod_wb_indicator_text_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_wb_indicator_text
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_wb_indicator_text_ui <- function(id){
  ns <- NS(id)
  tagList(
  
  )
}
    
# Module Server
    
#' @rdname mod_wb_indicator_text
#' @export
#' @keywords internal
    
mod_wb_indicator_text_server <- function(input, output, session){
  ns <- session$ns
}
    
## To be copied in the UI
# mod_wb_indicator_text_ui("wb_indicator_text_ui_1")
    
## To be copied in the server
# callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_1")
 
