This was a recruitment test for a company specialized in the development of data analytics and machine learning solutions for enterprise companies.
Most of their systems are programmed in R and use the Shiny package to create **dashboards**.

The dashboard I developed can be accesses at https://eduardodelpeloso.shinyapps.io/Map_Dashboard.

---

Using data in file 'ships.csv.tar.gz', build a Shiny app that meets the following goals:
- User can select a vessel type from the dropdown field.
- User can select a vessel name from a dropdown field (available vessels should correspond to selected type). Dropdown fields should be created as a Shiny module
For the vessel selected, find the observation when it sailed the longest distance between two consecutive observations (ca. 2 min.). If there is a situation when a vessel moves exactly the same amount of meters at the same time please select the most recent.  
- Display that on the map - show two points, the beginning and the end of the movement. Map should be created using the leaflet library. Changing type and vessel name should re-render the map and the note.
- Provide a short note saying how much the ship sailed - distance should be provided in meters.
