source("ship_data.R", local = TRUE)

shinyServer(function(input, output, session) {

  # Ship type and name
  shipTypeStr <- dropdownServer("ship_type")
  shipNameStr <- dropdownServer("ship_name")

  # When ship type is chosen, update list of ship names
  observeEvent(
    shipTypeStr(),
    update_dropdown_input(
      session, "ship_name-dropdown", sort(unique(ships_split[[shipTypeStr()]]["SHIPNAME"])[["SHIPNAME"]]),
      sort(unique(ships_split[[shipTypeStr()]]["SHIPNAME"])[["SHIPNAME"]])
    ),
  )

  # When ship is chosen, update map and distance traveled
  observeEvent(
    shipNameStr(),
    tagList(
      output$my_map <- renderLeaflet({
        result_ship_lat_lon <- ship_lat_lon(shipNameStr)

        # This avoids an error when the app is started because there is no data
        # available yet
        if (is.null(result_ship_lat_lon[[1]])) {
          return()
        }

        # Update distance traveled
        output$distance_travelled <- renderText(as.integer(result_ship_lat_lon[[1]]))

        # Update map
        leaflet() %>%
          addProviderTiles(providers$Stamen.TonerLite,
            options = providerTileOptions(noWrap = TRUE)
          ) %>%
          setView(lat = result_ship_lat_lon[[2]][3], lng = result_ship_lat_lon[[2]][1], zoom = 9) %>%
          addCircleMarkers(
            lat = result_ship_lat_lon[[2]][3],
            lng = result_ship_lat_lon[[2]][1],
            label = "Begin",
            labelOptions = labelOptions(noHide = T)
          ) %>%
          addCircleMarkers(
            lat = result_ship_lat_lon[[2]][4],
            lng = result_ship_lat_lon[[2]][2],
            label = "End",
            labelOptions = labelOptions(noHide = T)
          )
      })
    )
  )
})
