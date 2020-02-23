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
  
  ffd_data <- iapdashboard::ffd_by_country
  
  ffd_series <- reactive({
    dt <- ffd_data %>% 
      dplyr::ungroup() %>% 
      dplyr::filter(.data$reporter_iso == country()) %>% 
      dplyr::select(.data$year, .data$partner, .data$trade_val) 
    
    return(dt)
  })
  
  output$ffd_series <- echarts4r::renderEcharts4r({
    
    cns <- data.frame(country = c(country()))
    
    ffd_series() %>% 
      dplyr::ungroup() %>% 
      # dplyr::filter(.data$reporter_iso == "ARG") %>% 
      dplyr::select(.data$year, .data$partner, .data$trade_val) %>%  
      dplyr::group_by(.data$year) %>%
      dplyr::arrange(.data$year, -.data$trade_val) %>% 
      dplyr::slice(1:20) %>% 
      echarts4r::e_charts(x = partner) %>%
      echarts4r::e_bar(serie = trade_val) %>% 
      echarts4r::e_flip_coords() %>% 
      echarts4r::e_tooltip(trigger = "axis") %>% 
      echarts4r::e_legend(show = TRUE, orient = "vertical", right = 10, top = 20, bottom = 20, textStyle = list(color = "white")) %>% 
      echarts4r::e_title(text = as.character(echarts4r::e_country_names(cns, country, type = "iso3c")), textStyle = list(color = "white"))
      
      #       dplyr::group_by(.data$year) %>% 
      # dplyr::arrange(.data$year, -.data$trade_val) %>% 
      # # dplyr::filter(.data$year = 2015) %>% 
      # dplyr::slice(1:20) %>% 
      # echarts4r::e_charts(x = .data$partner) %>%
      # echarts4r::e_bar(serie = .data$trade_val, name = "Trade value") %>% 
      # echarts4r::e_tooltip(trigger = "axis") %>% 
      # echarts4r::e_legend(show = TRUE, textStyle = list(color = "white")) %>% 
      # echarts4r::e_title(text = as.character(echarts4r::e_country_names(cns, country, type = "iso3c")), textStyle = list(color = "white")) %>% 
      # echarts4r::e_text_style(color = "white") 
      # e_flip_coords() 

            # DT::datatable(ffd_series(),escape = FALSE, options = list(dom = "t"), rownames = FALSE) 
    # DT::formatCurrency(columns = c(2, 4, 8), digits = 0) 
    
  })
  
  
}
    
## To be copied in the UI
# mod_ffd_country_series_ui("ffd_country_series_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_country_series_server, "ffd_country_series_ui_1")
 
