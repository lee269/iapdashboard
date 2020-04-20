# Module UI
  
#' @title   mod_ffd_product_series_ui and mod_ffd_product_series_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ffd_product_series
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_ffd_product_series_ui <- function(id){
  ns <- NS(id)
  tagList(
    echarts4r::echarts4rOutput(outputId = ns("ffd_series"))    
  )
}
    
# Module Server
    
#' @rdname mod_ffd_product_series
#' @export
#' @keywords internal
    
mod_ffd_product_series_server <- function(input, output, session, country){
  ns <- session$ns
  
  
  output$ffd_series <- echarts4r::renderEcharts4r({
    echarts_product_series(country())
  })
  
  
}

echarts_product_series <- function(country){
 
  ffd_data <- iapdashboard::ffd_by_product
  
  dt <- ffd_data %>% 
    # dplyr::ungroup() %>% 
    dplyr::filter(.data$reporter_iso == country) %>% 
    dplyr::select(.data$year, .data$commodity_code, .data$commodity, .data$trade_val) %>% 
    dplyr::mutate(commodity = paste0(.data$commodity, " (", .data$commodity_code, ")")) %>%
    dplyr::select(.data$year, .data$commodity, .data$trade_val) %>%  
    # dplyr::filter(year == max(.data$year)) %>% 
    dplyr::group_by(.data$year) %>%
    dplyr::top_n(5, .data$trade_val) %>% 
    dplyr::arrange(-.data$year, -.data$trade_val) %>% 
    # dplyr::arrange(.data$trade_val) %>% 
    echarts4r::e_charts(x = commodity) %>%
    echarts4r::e_bar(serie = trade_val, itemStyle = list(color = "#ff9500")) %>% 
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
# mod_ffd_product_series_ui("ffd_product_series_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_product_series_server, "ffd_product_series_ui_1")
 
