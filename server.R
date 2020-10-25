source('ship_data.R', local = TRUE)

shinyServer(function(input, output, session) {
  
  output$second_dropdown <- renderUI({
    dropdown_input("simple_dropdown2", unique(df$SHIPNAME[df$ship_type == input[["simple_dropdown"]]]))
  })
  
  output$mymap <-renderLeaflet({
 
    result_ship_lat_lon <- ship_lat_lon(input[["simple_dropdown2"]])
    
    if (is.null(result_ship_lat_lon[[1]])) {
      return()
    }
       
    output$distance_travelled <- renderText(as.integer(result_ship_lat_lon[[1]]))
    
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)) %>%
      setView(lat=result_ship_lat_lon[[2]][3],lng=result_ship_lat_lon[[2]][1],zoom=9) %>%
      addCircleMarkers(data = result_ship_lat_lon[[2]])
    
  })
})