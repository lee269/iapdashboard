# Module UI
  
#' @title   mod_ffd_indicator_series_ui and mod_ffd_indicator_series_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ffd_indicator_series
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_ffd_indicator_series_ui <- function(id){
  ns <- NS(id)
  tagList(
    echarts4r::echarts4rOutput(outputId = ns("ffd_series"))
  )
}
    
# Module Server
    
#' @rdname mod_ffd_indicator_series
#' @export
#' @keywords internal
    
mod_ffd_indicator_series_server <- function(input, output, session, country){
  ns <- session$ns
  
  ffd_data <- iapdashboard::ffd_indicators
  
  ffd_series <- reactive({
    dt <- ffd_data %>% 
      dplyr::filter(.data$reporter_iso == country()) %>% 
      dplyr::ungroup() %>% 
      dplyr::select(-.data$reporter_code, -.data$reporter_iso, -.data$reporter, -.data$GBR, -.data$WLD) 

      return(dt)
  })
  
  output$ffd_series <- echarts4r::renderEcharts4r({
    
    cns <- data.frame(country = c(country()))
    
    opts <- list(textStyle = list(color = "blue"))
    
    ffd_series() %>% 
      echarts4r::e_charts(x = .data$year) %>% 
      echarts4r::e_x_axis(.data$year, formatter = echarts4r::e_axis_formatter("decimal")) %>% 
      echarts4r::e_line(serie = .data$uk_food_imports, name = "Total Imports") %>% 
      echarts4r::e_line(serie = .data$trade_value_us, name = "Top product") %>% 
      echarts4r::e_tooltip(trigger = "axis") %>% 
      echarts4r::e_toolbox_feature(feature = "dataView") %>% 
      echarts4r::e_legend(show = TRUE, textStyle = list(color = "white")) %>% 
      echarts4r::e_title(text = as.character(echarts4r::e_country_names(cns, country, type = "iso3c")), textStyle = list(color = "white")) %>% 
      echarts4r::e_text_style(color = "white")
    
    
    # DT::datatable(ffd_series(),escape = FALSE, options = list(dom = "t"), rownames = FALSE) 
    # DT::formatCurrency(columns = c(2, 4, 8), digits = 0) 
    
  })
  
}
    
## To be copied in the UI
# mod_ffd_indicator_series_ui("ffd_indicator_series_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_indicator_series_server, "ffd_indicator_series_ui_1")
 
