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
    tags$div(textOutput(outputId = ns("indicator_text"), inline = TRUE),
             tags$strong(textOutput(outputId = ns("indicator_val"), inline = TRUE)),
             style = paste0("color:", "#fff", ";"),
             align = "left")
    
  )
}
    
# Module Server
    
#' @rdname mod_wb_indicator_text
#' @export
#' @keywords internal
    
mod_wb_indicator_text_server <- function(input, output, session, country, indicator, format = "integer"){
  ns <- session$ns
  
  wbdata <- iapdashboard::wb_indicators
  
  wb_table <- reactive({
    dt <- wbdata %>% dplyr::filter(.data$reporter_iso == country(), .data$indicatorID == indicator())
    return(dt)
  })
  
  output$indicator_text <- renderText({
    # paste(wb_table(), indicator)
    paste0(wb_table()$indicator_short_text[1], ": ")
  })
  
  output$indicator_val <- renderText({
    paste0(format_number(wb_table()$value[1], format))
  })
  
}
    
## To be copied in the UI
# mod_wb_indicator_text_ui("wb_indicator_text_ui_1")
    
## To be copied in the server
# callModule(mod_wb_indicator_text_server, "wb_indicator_text_ui_1")
 
