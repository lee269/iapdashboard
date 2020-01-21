# Module UI
  
#' @title   mod_country_map_ui and mod_country_map_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#' @param dataset
#' @param country
#' @param height
#' @param width
#'
#' @rdname mod_country_map
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_country_map_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(outputId = ns("country_map_plot"), height = 100, width = 100)
  )
}
    
# Module Server
    
#' @rdname mod_country_map
#' @export
#' @keywords internal
    
mod_country_map_server <- function(input, output, session, country){
  ns <- session$ns
  
  world <- ggplot2::map_data("world")
  world <- world %>% dplyr::left_join(ffd_indicators, by = c("region" = "reporter"))
  
    country_map <- reactive({
    dt <- world %>% dplyr::filter(reporter_iso == country()) 
    return(dt)
  })
  
  output$country_map_plot <- renderPlot({
    ggplot2::ggplot() + ggplot2::geom_polygon(data = country_map(), ggplot2::aes(x = long, y = lat, group = group), fill = "gray50") + 
      ggplot2::coord_fixed(1.3) +
      ggplot2::theme_void() + 
      ggplot2::theme(plot.background = ggplot2::element_rect(fill = "#f5f5f5", colour = "#f5f5f5"))
  }, bg = "#f5f5f5")
  
}
    
## To be copied in the UI
# mod_country_map_ui("country_map_ui_1")
    
## To be copied in the server
# callModule(mod_country_map_server, "country_map_ui_1")
 
