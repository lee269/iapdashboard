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
  
  # Kludge. See:
  # https://stackoverflow.com/questions/48750221/dplyr-and-no-visible-binding-for-global-variable-note-in-package-check
  . = NULL
  
  ffd_data <- iapdashboard::ffd_indicators
  
  ffd_table <- reactive({
    dt <- ffd_data %>% 
          dplyr::filter(.data$reporter_iso == country(), .data$year == max(.data$year)) %>% 
          dplyr::ungroup() %>% 
          dplyr::select(-.data$reporter_code, -.data$reporter_iso, -.data$reporter, -.data$GBR, -.data$WLD) %>% 
          dplyr::mutate(total_food_imports_rating = paste(.data$total_food_imports_rating, rag(.data$total_food_imports_rating))) %>% 
          dplyr::mutate_at(c("total_food_imports_value", "uk_food_imports", "trade_value_us"), ~format_number(., "dollar")) %>% 
          dplyr::mutate_at(c("uk_market_share", "uk_percentage"), ~format_number(., "percent")) %>% 
          dplyr::mutate(commodity = paste0(.data$commodity, " (", .data$commodity_code, ")")) %>% 
          dplyr::select(`Year:` = .data$year,
                        `Total Food Imports:` = .data$total_food_imports_value,
                        `Food Imports Rating:` = .data$total_food_imports_rating,
                        `UK Food Imports:` = .data$uk_food_imports,
                        `UK Market Share:` = .data$uk_market_share,
                        `Top export commodity:` = .data$commodity,
                        `Top commodity trade value:` = .data$trade_value_us,
                        `Top commodity % of UK trade:` = .data$uk_percentage) %>%
          purrr::transpose() %>% .[[1]] %>%
          tibble::enframe()
    return(dt)
  })
  
  output$ffd_table <- DT::renderDT({
   DT::datatable(ffd_table(),escape = FALSE, options = list(dom = "t"), rownames = FALSE) 
      # DT::formatCurrency(columns = c(2, 4, 8), digits = 0) 
      
  })
  
}
    
## To be copied in the UI
# mod_ffd_indicator_table_ui("ffd_indicator_table_ui_1")
    
## To be copied in the server
# callModule(mod_ffd_indicator_table_server, "ffd_indicator_table_ui_1")
 
