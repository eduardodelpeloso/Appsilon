library(shiny)
library(shiny.semantic)
library(leaflet)

ship_types = unique(df$ship_type)

shinyUI(
  semanticPage(
    div(
      style="width: 100%; height: 100%; background-color: powderblue",
      id = "app-content",
      titlePanel("Shiny Developer @Appsilon - Recruitment Task"),
      sidebar_layout(
        sidebar_panel(
          p("Choose ship type:"),  
          dropdown_input("simple_dropdown", ship_types, value = ship_types[1],type = "selection fluid"),
          p(),
          p("Choose ship:"),
          uiOutput("second_dropdown"),
          br(),
          span(style="color:red; font-size: 20px",
               p("Distance travelled between displayed points (in meters):"),
               textOutput("distance_travelled"))
        ),
        main_panel(
          leafletOutput("mymap")
        )
      )
    )
  )
)