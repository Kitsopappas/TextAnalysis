# Install
#install.packages("tm")  # for text mining
#install.package("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes
#install.packages("ggplot2") #awesome plots


# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("ggplot2")

# Read the text file
filePath <- "https://raw.githubusercontent.com/Kitsopappas/TextAnalysis/master/sample.txt"
text <- readLines(filePath)

# μετατροπή δεδομένων σε corpus για text analysis
docs <- Corpus(VectorSource(text))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

# μετατροπή του κειμένου σε lowercase
docs <- tm_map(docs, content_transformer(tolower))

# Διαγραφή αριθμών
docs <- tm_map(docs, removeNumbers)

# Διαγραφή stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))

# Διαγραφή άχρηστων χαρακτήρων λόγω κωδικοποίησης
# specify your stopwords as a character vector
#docs <- tm_map(docs, removeWords, c("", "","")) 

# Διαγραφή !/./?/, γενικά τέτοια
docs <- tm_map(docs, removePunctuation)

# Μείωση του κενού χώρου
docs <- tm_map(docs, stripWhitespace)


# docs <- tm_map(docs, stemDocument)

# word frequencies
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

#export word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))


# bar plot 10 λέξεων
findFreqTerms(dtm, lowfreq = 4)
findAssocs(dtm, terms = "freedom", corlimit = 0.3)

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")

# dot plot 10 λέξεων
qplot(d[1:10,]$freq,d[1:10,]$word,data=d)

