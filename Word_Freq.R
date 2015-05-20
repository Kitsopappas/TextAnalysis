# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
install.packages("XML")#get and clean data from web site
install.packages("RCurl")

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("XML")
library("RCurl")

con = url("http://di.ionio.gr/")
txt = readLines(con)
close(con)

# convert HTML to text
txt <- lapply(txt, htmlToText)

txt <- sapply(txt, function(x) iconv(x, "latin1", "ASCII", sub=""))

txt <- gsub("<.*?>", "", txt)
txt <- gsub("<(script|style).+?</(script|style)>", "", txt)
txt <- gsub("<(?:\"[^\"]*\"[\'\"]*|\'[^\']*\'[\'\"]*|[^\'\">])+>", "", txt)
txt <- gsub("\t", "", txt)

#text.page <- readHTML("http://edition.cnn.com/")

# make corpus for text mining
corpus <- Corpus(txt)

#clean the text from crap
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
txt <- tm_map(txt, "", "/")
txt <- tm_map(txt, "", "@")
txt <- tm_map(txt, "", "\\|")

# Convert the text to lower case
txt <- tm_map(txt, content_transformer(tolower))

# Remove numbers
txt <- tm_map(txt, removeNumbers)

# Remove english common stopwords
txt <- tm_map(txt, removeWords, stopwords("english"))

# Remove your own stop word
# specify your stopwords as a character vector
txt <- tm_map(txt, removeWords, c("\t", "www")) 

# Remove punctuations
txt <- tm_map(txt, removePunctuation)

# Eliminate extra white spaces
txt <- tm_map(txt, stripWhitespace)

txt <- TermDocumentMatrix(txt)



dtm <- TermDocumentMatrix(txt)
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
