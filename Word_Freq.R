# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("XML")#get and clean data from web site

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("XML")

text.page <- readHTML("http://di.ionio.gr/el/")

#clean the text from crap
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
text.page <- tm_map(text.page, "", "/")
text.page <- tm_map(text.page, "", "@")
text.page <- tm_map(text.page, "", "\\|")

# Convert the text to lower case
text.page <- tm_map(text.page, content_transformer(tolower))

# Remove numbers
text.page <- tm_map(text.page, removeNumbers)

# Remove english common stopwords
text.page <- tm_map(text.page, removeWords, stopwords("english"))

# Remove your own stop word
# specify your stopwords as a character vector
text.page <- tm_map(text.page, removeWords, c("\t", "www")) 

# Remove punctuations
text.page <- tm_map(text.page, removePunctuation)

# Eliminate extra white spaces
text.page <- tm_map(text.page, stripWhitespace)

text.page <- TermDocumentMatrix(text.page)



dtm <- TermDocumentMatrix(text.page)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
data.txt <- data.frame(word = names(v),freq=v)
head(data.txt, 10)


readHTML <- function(site){

# Read and parse HTML file
doc.html = htmlTreeParse(site,
                         useInternal = TRUE)

# Extract all the paragraphs (HTML tag is p, starting at
# the root of the document). Unlist flattens the list to
# create a character vector.
doc.text = unlist(xpathApply(doc.html, '//p', xmlValue))

# Replace all \n by spaces
doc.text = gsub('\\n', ' ', doc.text)

# Join all the elements of the character vector into a single
# character string, separated by spaces
doc.text = paste(doc.text, collapse = ' ')
}
