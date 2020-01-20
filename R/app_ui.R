#' @import shiny
app_ui <- function() {

# UI elements -------------------------------------------------------------

  country_selector <- wellPanel(mod_country_select_ui("country_select_ui_1", data = ffd_indicators))
  
  flag_section <- wellPanel(
    splitLayout(mod_country_flag_ui("country_flag_ui_1"),
                mod_country_map_ui("country_map_ui_1"),
                cellWidths = c("40%", "60%"))
  )
  
  wb_section <- wellPanel(mod_test_ui("test_ui_1")
  )
  
  body_section <- mainPanel(tags$h3("Some stuff"),
                            tags$h3("And some more stuff")
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
