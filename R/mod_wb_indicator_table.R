# Module UI
  
#' @title   mod_wb_indicator_table_ui and mod_wb_indicator_table_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_wb_indicator_table
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
#' @importFrom rlang .data
mod_wb_indicator_table_ui <- function(id){
  ns <- NS(id)
  tagList(
          DT::DTOutput(outputId = ns("indicator_table"))
  )
}
    
# Module Server
    
#' @rdname mod_wb_indicator_table
#' @export
#' @keywords internal
    
mod_wb_indicator_table_server <- function(input, output, session, country, indicator){
  ns <- session$ns
  
  wbdata <- iapdashboard::wb_indicators
  
  wb_table <- reactive({
    dt <- wbdata %>% dplyr::filter(.data$reporter_iso == country(), .data$indicatorID == indicator())
    return(dt)
  })
  
  output$indicator_table <- DT::renderDT({
    # paste(wb_table(), indicator)
    wb_table()
  })
  
}
    
## To be copied in the UI
# mod_wb_indicator_table_ui("wb_indicator_table_ui_1")
    
## To be copied in the server
# callModule(mod_wb_indicator_table_server, "wb_indicator_table_ui_1")
 
