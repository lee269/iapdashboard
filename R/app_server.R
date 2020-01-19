#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  callModule(mod_country_select_server, "country_select_ui_1")
}
