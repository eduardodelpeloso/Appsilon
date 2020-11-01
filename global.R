library(shiny)


ships <- read.csv('ships.csv')
ship_types <- sort(unique(ships$ship_type))
ships_split <- split(ships, ships$ship_type)

# Module UI encapsulating dropdown_input
dropdownUI <- function(id, label, choices, choices_value = "", value = "") {
  ns <- NS(id)
  dropdown_input(ns("dropdown"), label, choices = choices, choices_value = choices_value, value = value)
}

# Module server encapsulating dropdown_input
dropdownServer <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      reactive({input$dropdown})
    }
  )
}
