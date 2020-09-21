#Load the lobraries
library(leaflet)
library(dplyr)

#Read the data into R
myData <- read.csv("assignment-02-data-formated.csv", stringsAsFactors = FALSE)

#Combining the colors set for each of the locations
location_colors <- c(site01 = "red",
                     site02 = "green",
                     site03 = "yellow",
                     site04 = "cyan",
                     site05 = "magenta",
                     site06 = "orange",
                     site07 = "dark blue",
                     site08 = "pink"
)
color <- colorFactor(location_colors,myData$location)
#create the leaflet
locations <- leaflet(myData) %>% 
  addTiles() %>% 
  addCircleMarkers( popup =~as.character(location),
                    label = ~as.character(location),
                    color = ~color(myData$location)) %>%
  addLegend("bottomleft",
            pal=color,
            opacity = 1,
            values = myData$location,
            title = "Locations")
#view the leaflet
locations
