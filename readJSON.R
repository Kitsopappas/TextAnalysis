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