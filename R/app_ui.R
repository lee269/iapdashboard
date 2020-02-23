#' @import shiny
app_ui <- function() {

# UI elements -------------------------------------------------------------

  country_selector <- wellPanel(mod_country_select_ui("country_select_ui_1"))
  
  flag_section <- wellPanel(
    splitLayout(mod_country_flag_ui("country_flag_ui_1"),
                mod_country_map_ui("country_map_ui_1"),
                cellWidths = c("40%", "60%"))
  )
  
  wb_section <- wellPanel(tags$h2("World Bank indicators"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_pop"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_gdp"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_imports"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_bus_ease"),
                          mod_wb_indicator_text_ui("wb_indicator_text_ui_food_imports")
  )
  
  body_section <- shinyMobile::f7Items(
                            shinyMobile::f7Item(tabName = "market_overview",
                                                mod_ffd_indicator_table_ui("ffd_indicator_table_ui_1"),
                                                mod_ffd_indicator_series_ui("ffd_indicator_series_ui_1")),
                            shinyMobile::f7Item(tabName = "detail",
                                                tags$h3("And some more indicators"),
                                                mod_ffd_country_series_ui("ffd_country_series_ui_1"),
                                                mod_ffd_product_series_ui("ffd_product_series_ui_1")
                                                ),
                            shinyMobile::f7Item(tabName = "todo", includeMarkdown("./inst/app/www/todo.md"))
  )

  panel_menu <- shinyMobile::f7PanelMenu(
                  id = "menu",
                  shinyMobile::f7PanelItem(tabName = "market_overview", title = "Market Overview", icon = shinyMobile::f7Icon("email"), active = TRUE),
                  shinyMobile::f7PanelItem(tabName = "detail", title = "Detail", icon = shinyMobile::f7Icon("home")),
                  shinyMobile::f7PanelItem(tabName = "todo", title = "To do", icon = shinyMobile::f7Icon("home"))
                )

# Main dashboard ----------------------------------------------------------

  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    shinyMobile::f7Page(title = "Dashboard", 
                        init = shinyMobile::f7Init(skin = "md",
                                                   theme = "dark",
                                                   color = "yellow"),
                        shinyMobile::f7SplitLayout(
                                        sidebar = shinyMobile::f7Panel(inputId = "sidebar",
                                                                       title = "My sidebar",
                                                                       side = "left",
                                                                       theme = "dark",
                                                                       country_selector,
                                                                       br(), br(), br(),
                                                                       panel_menu,
                                                                       flag_section,
                                                                       wb_section
                                        ),
                                        navbar = shinyMobile::f7Navbar(title = "A Dashboard"),
                                        # main content
                                        body_section
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
