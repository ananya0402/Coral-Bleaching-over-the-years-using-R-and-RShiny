#load the libraries
library(shiny)
library(datasets)
library(leaflet)
library(ggplot2)
library(dplyr)

#user-interface script
ui<-fluidPage(
  headerPanel("Coral Bleaching at the Great Barrier Reef during 2010 to 2017"),
  sidebarLayout(
  sidebarPanel(
    selectInput("coralType", "Please Select Coral Type",
                choices=c("blue corals","soft corals",
                          "hard corals","sea pens","sea fans")),
    
    
    selectInput("Smoothers","Please select smoother",
                choices=c("loess","lm","gam","auto","glm")
                
    )),
    
    mainPanel(
      plotOutput("coralPlot"),
      leafletOutput("locations")
    )
  ))

#server script
server<-function(input, output){
  #read the data
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
  
  #present the created the leaflet
  output$locations <- renderLeaflet({
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
  })
  
  #Convert the types of the variables
  myData$value <-as.numeric(sub("%", "", as.character(myData$value)))
  myData$value<-myData$value/100
  myData$location<-as.character((myData$location))
  
  #Sorting the data by latitude
  myData<-myData[order(myData$latitude),]
  myDatalocation<-unique(myData$location)
  myDatalocation
  myData$location<-factor((myData$location),levels=myDatalocation)
  
  #Filter the data with the requested coral type
  filtered_data <- reactive({
    dplyr::filter(myData, coralType == input$coralType)
  })
  
  #map the sites of the ggplot graph to those of the leaflet by color
  output$coralPlot <- renderPlot({
    ggplot(filtered_data(),aes(x = year,y = value,fill=location))+
      geom_point()+facet_grid(location~input$coralType,scales="free")+
      scale_fill_manual(values=location_colors)+
      geom_smooth(method=input$Smoothers)
    
    
  })
  
}

shinyApp(ui = ui, server = server)

