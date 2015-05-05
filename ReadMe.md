#R Scripts


#Read XML
```sh
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
```
#Word Count Freq
```sh
dtm <- TermDocumentMatrix(text.page)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
data.txt <- data.frame(word = names(v),freq=v)
head(data.txt, 10)
```
#data.table package
```sh
library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)

DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)
```
#getting and cleanning data(Download File from the web)
```sh
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv ", destfile = "cameras.csv")
dateDownloaded <- date()

cameraData <- read.table("cameras.csv", sep = ",", header = TRUE)

cameraData
```
#read JSON data
```sh
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/Kitsopappas/repos")
names(jsonData)

#owner
names(jsonData$owner)
#repos
jsonData$owner$repos_url

#dataset to JSON
myJson <- toJSON(iris,pretty=TRUE)
cat(myJson)

#convert from JSON
iris2 <- fromJSON(myJson)
head(iris2)
```
