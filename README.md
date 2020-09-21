# Coral Bleaching over the years using R and RShiny

The dataset shows percentage (%) of coral bleaching for 8 sites and different types of coral in the Great Barrier Reef over the last 8 years. 
One thing to be noted is that not all sites have data for the entire period and not all corals are found at each site.
The following have been done:
* Reading the dataset into R.
* Creating a static visualisation using ggplot2 that shows how the bleaching varies over the years for each type of coral and for each site (static visualisation.R)
  * The visualisation uses faceting with each facet showing the bleaching for a type of coral at one site across the time period.
  * The sites should be ordered by latitude.
  * The visualisation shows line smoothing of the data.
* Creating a map using Leaflet that shows the location of the sites (leaflet.R)
* Extending the static visualisation specified on point 2 into an interactive Shiny visualisation that allows users to choose the type of coral to be displayed and the choice of smoother.
  * Merging the map into your interactive Shiny visualisation where the user can choose the type of coral and the type of smoother in order to analyse the bleaching rate over the years (shiny app.R)
