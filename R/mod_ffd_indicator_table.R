# Module UI
  
#' @title   mod_ffd_indicator_table_ui and mod_ffd_indicator_table_server
#' @description  Shiny module. Produces a DT datatable of trade indicators for
#'   the Market overview section.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#' @param a reactive containing a country ISO3 code
#'
#' @return a rendered reactive DT datatable
#'
#' @rdname mod_ffd_indicator_table
#'
#' @keywords internal
#' @export
#' @importFrom shiny NS tagList
#' @importFrom rlang .data
mod_ffd_indicator_table_ui <- function(id){
  ns <- NS(id)
  tagList(
          DT::DTOutput(outputId = ns("ffd_table"))
  )
}
    
# Module Server
    
#' @rdname mod_ffd_indicator_table
#' @export
#' @keywords internal
    
mod_ffd_indicator_table_server <- function(input, output, session, country){
  ns <- session$ns
  
  ffd_data <- iapdashboard::ffd_indicators
  
  ffd_table <- reactive({
    dt <- ffd_data %>% 
          dplyr::filter(.data$reporter_iso == country(), .data$year == max(.data$year)) %>% 
          dplyr::ungroup() %>% 
          dplyr::mutate(o = paste("23",rag(.data$total_food_imports_rating))) %>% 
          dplyr::select(-.data$reporter_code, -.data$reporter_iso, -.data$reporter, -.data$GBR, -.data$WLD) %>% 
          purrr::transpose() %>% .[[1]] %>%
          tibble::enframe()
    return(dt)
  })
  
  output$ffd_table <- DT::renderDT({
   DT::datatable(ffd_table(),escape = FALSE, options = list(dom = "t")) 
      # DT::formatCurrency(columns = c(2, 4, 8), digits = 0) 
      
  })
  
}
    
## To be copied in the UI
# mod_ffd_indicator_table_ui("ffd_indicator_table_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_indicator_table_server, "ffd_indicator_table_ui_1")
 
