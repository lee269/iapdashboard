# Module UI
  
#' @title   mod_wb_indicator_text_ui and mod_wb_indicator_text_server
#' @description  Shiny module. Produce html text to describe a World Bank
#'   indicator.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#' @param country ISO3 country code
#' @param indicator Code for World Bank indicator
#'
#' @return reactive HTML of indicator text.
#'
#' @rdname mod_wb_indicator_text
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
#' @importFrom rlang .data
mod_wb_indicator_text_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    tags$strong(textOutput(outputId = ns("indicator_text")))
  )
}
    
# Module Server
    
#' @rdname mod_wb_indicator_text
#' @export
#' @keywords internal
    
mod_wb_indicator_text_server <- function(input, output, session, country, indicator){
  ns <- session$ns
  
  wbdata <- iapdashboard::wb_indicators
  
  wb_table <- reactive({
    dt <- wbdata %>% dplyr::filter(.data$reporter_iso == country(), .data$indicatorID == indicator())
    return(dt)
  })
  
  output$indicator_text <- renderText({
    # paste(wb_table(), indicator)
    paste(wb_table()$indicator_short_text[1], ":", wb_table()$value[1])
  })
  
  
}
    
## To be copied in the UI
# mod_wb_indicator_text_ui("wb_indicator_text_ui_1")
    
## To be copied in the server
# callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_1")
 
