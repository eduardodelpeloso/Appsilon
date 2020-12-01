# Calculate the largest distance traveled between two consecutive
# observations of a ship. Return lat/lon of the begin and end
# of this leg, and the distance traveled
ship_lat_lon <- function(ship_name) {

  # Get list of observations of ship_name
  result <- ships[ships$SHIPNAME == ship_name(), ]

  # This avoids an error when the app is started because there is no data
  # available yet
  if (is.null(ship_name()) || ship_name() == "") {
    return(list(NULL, NULL))
  }

  datetime_begin <- strptime(result[1, "DATETIME"], "%Y-%m-%d %H:%M:%S")
  lat_max_dist_begin <- result[1, "LAT"]
  lon_max_dist_begin <- result[1, "LON"]
  datetime1 <- datetime_begin
  lat1 <- lat_max_dist_begin
  lon1 <- lon_max_dist_begin
  max_dist <- 0.0

  for (row in 2:nrow(result)) {
    datetime2 <- strptime(result[row, "DATETIME"], "%Y-%m-%d %H:%M:%S")
    lat2 <- result[row, "LAT"]
    lon2 <- result[row, "LON"]

    diftime <- as.numeric(difftime(datetime2, datetime1, units = "secs"))

    # If time between two observations of the same ship is > 5 minutes
    # then the observation is ignored
    if (abs(diftime) > 300) {
      lat1 <- lat2
      lon1 <- lon2
      datetime1 <- datetime2
      next
    }

    distance <- dist_2_pt(lat1, lon1, lat2, lon2)
    if (distance >= max_dist) {
      max_dist <- distance
      lat_max_dist_begin <- lat1
      lon_max_dist_begin <- lon1
      lat_max_dist_end <- lat2
      lon_max_dist_end <- lon2
    }

    lat1 <- lat2
    lon1 <- lon2
    datetime1 <- datetime2
  }

  return(list(max_dist, array(c(
    lon_max_dist_begin, lon_max_dist_end,
    lat_max_dist_begin, lat_max_dist_end
  ), c(2, 2))))
}

# Convert angle in degrees to radians
deg2rad <- function(deg) {
  return(deg * pi / 180.0)
}

# Calculate the distace in meters between two points in the
# Earth given their latitude and longitude
dist_2_pt <- function(lat1, lon1, lat2, lon2) {
  R <- 6371.0

  lat_distance <- deg2rad(lat2 - lat1)
  lon_distance <- deg2rad(lon2 - lon1)
  a <- sin(lat_distance / 2.0) * sin(lat_distance / 2.0) +
    cos(deg2rad(lat1)) * cos(deg2rad(lat2)) *
      sin(lon_distance / 2.0) * sin(lon_distance / 2.0)
  c <- 2.0 * atan2(sqrt(a), sqrt(1.0 - a))
  distance <- R * c * 1000.0

  return(distance)
}
