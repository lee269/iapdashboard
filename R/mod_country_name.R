# Module UI
  
#' @title   mod_country_name_ui and mod_country_name_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_country_name
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_country_name_ui <- function(id){
  ns <- NS(id)
  tagList(
        tags$p(textOutput(outputId = ns("country_name")), style = paste0("color:", "#fff", ";"))
  )
}
    
# Module Server
    
#' @rdname mod_country_name
#' @export
#' @keywords internal
    
mod_country_name_server <- function(input, output, session, country){
  ns <- session$ns

  output$country_name <- renderText({
    cns <- data.frame(country = c(country()))
    paste0(as.character(echarts4r::e_country_names(cns, country, type = "iso3c")))
  })
}
    
## To be copied in the UI
# mod_country_name_ui("country_name_ui_1")
    
## To be copied in the server
# callModule(mod_country_name_server, "country_name_ui_1")
 
