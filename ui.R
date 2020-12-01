library(shiny)
library(shiny.semantic)
library(leaflet)

shinyUI(
  semanticPage(
    div(
      style = "width: 100%; height: 100%; background-color: powderblue",
      id = "app-content",
      titlePanel("Map_Dashboard"),
      sidebar_layout(
        sidebar_panel(
          dropdownUI("ship_type", "Choose ship type:", ship_types, ship_types, ship_types[1]),
          p(),
          dropdownUI("ship_name", "Choose ship:", NULL),
          br(),
          span(
            style = "color:red; font-size: 20px",
            p("Distance travelled between displayed points (in meters):"),
            textOutput("distance_travelled")
          )
        ),
        main_panel(
          leafletOutput("my_map")
        )
      )
    )
  )
)
