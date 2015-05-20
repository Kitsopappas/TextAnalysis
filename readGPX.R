library(ggplot2)
library(plotKML)
file <- readGPX("C:/xampp/htdocs/gpx/user1.gpx",metadata=TRUE,bounds=TRUE,waypoint=TRUE,tracks=TRUE,routes=TRUE)
data <- file$tracks[[1]]$Akis_user1_AB

write.csv(data, file = "gpx.csv",sep=",")

# Make lat/long data numeric
data$lat <- as.numeric(as.character(data$lat))
data$lon <- as.numeric(as.character(data$lon))



#create nice plot
data <- qplot(lon, lat, data=data, shape="point",
              main="Map",
              xlab="Longitude", ylab="Latitude")

