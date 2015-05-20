#__auth = Pappas Xristodoulos
#   Ionian University 2015

#     R version 3.2.0

#Reads a txt file from the web and does a ritual cleanning
#then finds every words frequency in a document
#and creates a word cloud a bar chart and a dot plot

#--------------Sample output of the project--------------
          #           word  | freq          #
                      -----  -----
#          said    |    said  | 659                     #
#          one     |     one  | 414                     #
#          lorry   |   lorry  | 321                     #  
#          upon    |    upon  | 286                     #  
#          will    |    will  | 269                     #
#          defarge | defarge  | 268                     #
#          man     |     man  | 264                     #
#          little  |  little  | 263                     #
#          time    |    time  | 246                     #
#          hand    |    hand  | 240                     #
#--------------------------------------------------------

# Install
#install.packages("tm")  # for text mining
#install.package("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes
#install.packages("ggplot2") #awesome plots
#install.packages("NbClust")

 
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
library("ggplot2")
library("NbClust")

cat(sprintf("I will do some cleanning now... wait!"))

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


cat(sprintf("Wait for it!"))
#export word cloud
set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
cat(sprintf("There is a word cloud. Awesome uh??"))

# bar plot 10 λέξεων
findFreqTerms(dtm, lowfreq = 4)
findAssocs(dtm, terms = "freedom", corlimit = 0.3)

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="cadetblue4", main ="Most frequent words",
        ylab = "Word frequencies")

# dot plot 10 λέξεων
qplot(d[1:10,]$word,d[1:10,]$freq,data=d,color=d[1:10,]$freq,
      main="Most frequent words dot",xlab = "Words", ylab="Frequency")

#-----------------k-means-----------------
### don't forget to normalize the vectors so Euclidean makes sense
norm_eucl <- function(m) m/apply(m, MARGIN=1, FUN=function(x) sum(x^2)^.5)
m_norm <- norm_eucl(m)


### cluster into 10 clusters
cl <- kmeans(m_norm, 10)
table(cl$cluster)


barplot(table(cl$cluster),
        main="Number of Clusters")

#---------------------FUNCTIONS----------------------

wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}

