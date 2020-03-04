#' @import shiny
app_ui <- function() {

# UI elements -------------------------------------------------------------

  # Country select dropdown
  country_selector <- tagList(mod_country_select_ui("country_select_ui_1"))
  
  # Flag card
  flag_section <- shinyMobile::f7Card(
    splitLayout(mod_country_flag_ui("country_flag_ui_1"),
                mod_country_map_ui("country_map_ui_1"), cellWidths = 140)
  )
  
  # World Bank indicator card
  wb_section <- shinyMobile::f7Card(
                                    mod_wb_indicator_text_ui("wb_indicator_text_ui_pop"),
                                    mod_wb_indicator_text_ui("wb_indicator_text_ui_gdp"),
                                    mod_wb_indicator_text_ui("wb_indicator_text_ui_imports"),
                                    mod_wb_indicator_text_ui("wb_indicator_text_ui_bus_ease"),
                                    mod_wb_indicator_text_ui("wb_indicator_text_ui_food_imports")
  )
  
  # FFD indicator card
  indicator_section <- shinyMobile::f7Card(mod_ffd_indicator_table_ui("ffd_indicator_table_ui_1"))
  
  # FFD indicator series card
  indicator_series <- shinyMobile::f7Card(mod_ffd_indicator_series_ui("ffd_indicator_series_ui_1"))
  
  # Top country chart
  top_country_chart <- shinyMobile::f7Card(mod_ffd_country_series_ui("ffd_country_series_ui_1"), title = "Top countries")
  
  # Top product chart
  top_product_chart <- shinyMobile::f7Card(mod_ffd_product_series_ui("ffd_product_series_ui_1"), title = "Top products")
  
  # To do text
  to_do <- shinyMobile::f7Card(includeMarkdown("./inst/app/www/todo.md"))
  
  
  # Old stuff
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
                        shinyMobile::f7TabLayout(
                          navbar = shinyMobile::f7Navbar(
                            title = tags$h2(mod_country_name_ui("country_name_ui_navbar")),
                            left_panel = TRUE
                          ),
                          panels = tagList(
                            shinyMobile::f7Panel(title = "Trade dashboard",
                                                 side = "left",
                                                 theme = "dark",
                                                 effect = "reveal",
                                                 p("pick a country"),
                                                 country_selector
                            )
                          ),
                          shinyMobile::f7Tabs(
                            animated = TRUE,
                            id = "tabs",
                            shinyMobile::f7Tab(
                              tabName = "Home",
                              icon = shinyMobile::f7Icon("home"),
                              active = TRUE,
                              # top row
                              shinyMobile::f7Row(
                                shinyMobile::f7Col(
                                  flag_section
                                ),
                                shinyMobile::f7Col(
                                  wb_section
                                ),
                                shinyMobile::f7Col(),
                                shinyMobile::f7Col()
                              ),
                              # second row
                              shinyMobile::f7Row(
                                shinyMobile::f7Col(
                                  indicator_section
                                ),
                                shinyMobile::f7Col(
                                  indicator_series
                                )
                              )
                            ), #close home tab
                            shinyMobile::f7Tab(
                              tabName = "Details",
                              shinyMobile::f7Row(
                                shinyMobile::f7Col(
                                 top_country_chart 
                                ),
                                shinyMobile::f7Col(
                                  top_product_chart
                                )
                              )
                              
                            ),
                            shinyMobile::f7Tab(
                              tabName = "To do",
                              to_do
                            )
                            
                          ) #close f7Tabs
                        ) #close f7tablayoout
    ) #close f7Page
  ) #close overall taglist
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'iapdashboard')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon(),
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    tags$link(rel="stylesheet", type="text/css", href="www/style.css")
  )
}
