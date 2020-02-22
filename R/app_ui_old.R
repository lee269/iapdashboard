#' @import shiny
app_ui_old <- function() {

# UI elements -------------------------------------------------------------

  country_selector <- wellPanel(mod_country_select_ui("country_select_ui_1"))
  
  flag_section <- wellPanel(
    splitLayout(mod_country_flag_ui("country_flag_ui_1"),
                mod_country_map_ui("country_map_ui_1"),
                cellWidths = c("40%", "60%"))
  )
  
  wb_section <- wellPanel(tags$h4("World Bank indicators"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_pop"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_gdp"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_imports"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_bus_ease"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_food_imports")
  )
  
  body_section <- tabsetPanel(
                            tabPanel("Market overview",
                                     mod_ffd_indicator_table_ui("ffd_indicator_table_ui_1"),
                                     mod_ffd_indicator_series_ui("ffd_indicator_series_ui_1")),
                            tabPanel("Detail", tags$h3("And some more indicators")),
                            tabPanel("To do", includeMarkdown("./docs/todo.md"))
  )

  

# Main dashboard ----------------------------------------------------------

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      # titlePanel("Dashboard"),
      column(width = 3,
             fluidRow(country_selector),
             fluidRow(flag_section),
             fluidRow(wb_section)
      ),
      column(width = 9,
             fluidRow(body_section)
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'iapdashboard')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
