#Load the libraries
library(ggplot2)

#Read the data into R
myData <- read.csv("assignment-02-data-formated.csv")

#Convert the type of the variables
myData$value <-as.numeric(sub("%", "", as.character(myData$value)))
myData$value<-myData$value/100
myData$location<-as.character((myData$location))

#Sorting the data by latitude
myData<-myData[order(myData$latitude),]
myDatalocation<-unique(myData$location)
myData$location<-factor((myData$location),levels=myDatalocation)

#ggplot graph to show the bleaching value of each coral type for each location during 2010 to 2017 
myGraph <-ggplot(data = myData,aes(x = year,y = value,colour=coralType))
myGraph + geom_point() + facet_grid(location~coralType, scales="free") +
          geom_smooth(method="lm") +ylab("Bleaching value") 


















