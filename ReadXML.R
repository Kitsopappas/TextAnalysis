library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

#rootNode[[1]]
#rootNode[[1]][[4]]

#xmlSApply(rootNode,xmlValue)

#find vaules that have a tag name/price
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)
#end


### read tags from site with xpath language ;)
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores



