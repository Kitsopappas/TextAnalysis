fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ", destfile = "cameras.csv")
dateDownloaded <- date()

cameraData <- read.table("cameras.csv", sep = ",", header = TRUE)

cameraData