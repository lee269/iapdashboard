# Module UI
  
#' @title   mod_ffd_country_series_ui and mod_ffd_country_series_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ffd_country_series
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_ffd_country_series_ui <- function(id){
  ns <- NS(id)
  
  tagList(
    echarts4r::echarts4rOutput(outputId = ns("ffd_series"))  
  )
}
    
# Module Server
    
#' @rdname mod_ffd_country_series
#' @export
#' @keywords internal
    
mod_ffd_country_series_server <- function(input, output, session, country){
  ns <- session$ns
  
  output$ffd_series <- echarts4r::renderEcharts4r({
    echarts_country_series(country())
  })
  
}


echarts_country_series <- function(country){
 
   ffd_data <- iapdashboard::ffd_by_country
   
   dt <- ffd_data %>% 
     dplyr::ungroup() %>% 
     dplyr::filter(.data$reporter_iso == country) %>% 
     dplyr::select(.data$year, .data$partner, .data$trade_val) %>%
     # dplyr::filter(year == max(.data$year)) %>% 
     dplyr::group_by(.data$year) %>%
     dplyr::top_n(10, .data$trade_val) %>% 
     dplyr::arrange(-.data$year, -.data$trade_val) %>% 
     echarts4r::e_charts(x = partner) %>%
     echarts4r::e_bar(serie = trade_val,itemStyle = list(color = "#ff9500")) %>% 
     echarts4r::e_flip_coords() %>%
     echarts4r::e_tooltip(trigger = "axis") %>% 
     echarts4r::e_legend(show = TRUE, 
                         orient = "vertical",
                         right = 10, 
                         top = 20,
                         bottom = 20,
                         textStyle = list(color = "white"),
                         selectedMode = "single") %>% 
     echarts4r::e_theme(echarts_theme) 
   
   dt
}

    
## To be copied in the UI
# mod_ffd_country_series_ui("ffd_country_series_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_country_series_server, "ffd_country_series_ui_1")
 
