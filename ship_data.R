ship_lat_lon <- function(shipName) {
  
  result = df[df$SHIPNAME == shipName, ]

  if (is.null(shipName) || shipName == "") {
    return(list(NULL, NULL))
  }
  
  datetime_begin = strptime(result[1, "DATETIME"], "%Y-%m-%d %H:%M:%S")
  lat_max_dist_begin = result[1, "LAT"]
  lon_max_dist_begin = result[1, "LON"]
  datetime1 = datetime_begin
  lat1 = lat_max_dist_begin
  lon1 = lon_max_dist_begin
  max_dist = 0.0
  
  for (row in 2:nrow(result)) {
    datetime2 = strptime(result[row, "DATETIME"], "%Y-%m-%d %H:%M:%S")
    lat2 = result[row, "LAT"]
    lon2 = result[row, "LON"]
    
    diftime = as.numeric(difftime(datetime2, datetime1, units = 'secs'))
    
    # If time between two observations of the same ship is > 5 minutes
    # then the observation is ignored
    if (abs(diftime) > 300) {
      lat1 = lat2
      lon1 = lon2
      datetime1 = datetime2
      next      
    }
    
    distance = dist_2_pt(lat1, lon1, lat2, lon2)
    if (distance >= max_dist) {
      max_dist = distance
      lat_max_dist_begin = lat1
      lon_max_dist_begin = lon1
      lat_max_dist_end = lat2
      lon_max_dist_end = lon2
    }
    
    lat1 = lat2
    lon1 = lon2
    datetime1 = datetime2
  }

  return(list(max_dist, array(c(lon_max_dist_begin, lon_max_dist_end, 
                    lat_max_dist_begin, lat_max_dist_end), c(2, 2))))
}

deg2rad <- function(deg) {
  return(deg * pi / 180.0)
}

dist_2_pt <- function(lat1, lon1, lat2, lon2) {
  
    R = 6371.0
    
    latDistance = deg2rad(lat2 - lat1);
    lonDistance = deg2rad(lon2 - lon1);
    a = sin(latDistance / 2.0) * sin(latDistance / 2.0) +
      cos(deg2rad(lat1)) * cos(deg2rad(lat2)) *
      sin(lonDistance / 2.0) * sin(lonDistance / 2.0)
    c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a))
    distance = R * c * 1000.0
    
    return(distance)
}
