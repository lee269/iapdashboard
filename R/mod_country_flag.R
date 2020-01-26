# Module UI
  
#' @title   mod_country_flag_ui and mod_country_flag_server
#' @description  Shiny module. Produces an html link to a country flag image.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#' @param country, list containing reactive country name (reporter_iso) to
#'   filter on
#' @param height, text containing either percentage ("50\%") or pixel size
#'   ("640")
#' @param width, text containing either percentage ("50\%") or pixel size
#'   ("640")
#'
#' @return link to a flag image from Wikipedia.
#'
#' @rdname mod_country_flag
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
#' @importFrom rlang .data
mod_country_flag_ui <- function(id){
  ns <- NS(id)
  tagList(
    htmlOutput(outputId = ns("country_flag_url"))
  )
}
    
# Module Server
    
#' @rdname mod_country_flag
#' @export
#' @keywords internal
mod_country_flag_server <- function(input, output, session, country, height = "100%", width = "100%"){
  ns <- session$ns

  flagdata <- iapdashboard::countries
  
    country_meta <- reactive({
    dt <- flagdata %>% dplyr::filter(.data$reporter_iso == country()) %>% dplyr::select(.data$png) %>% as.character() 
    return(dt)
  })
  
  output$country_flag_url <- renderText({
    c('<img src="', country_meta(),'", height = "', height, '", width = "', width, '">')
  })
  
}
    
## To be copied in the UI
# mod_country_flag_ui("country_flag_ui_1")
    
## To be copied in the server
# callModule(mod_country_flag_server, "country_flag_ui_1")
 
