# Directions:

# This file contains homework questions for the lecture on data visualization.
# Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################


# Write an R code snippet that uses regular expressions to find all occurrences of 
# dates in the string variable text that are in the format "dd/mm/yyyy" and replace 
# them with the format "yyyy-mm-dd". The text variable contains multiple dates in 
# the "dd/mm/yyyy" format interspersed with other text. For example, if text is 
# "The event was held on 23/04/2021 and the next event will be on 05/10/2022.", 
# the output should be "The event was held on 2021-04-23 and the next 
# event will be on 2022-10-05.".
#
# Ensure your code dynamically handles the text variable, meaning it should work 
# for any string input following the mentioned pattern. Use relevant functions from 
# the stringr package, any other package, or base R for your solution.

# Load library
library(stringr)

# strings with dates in the format "dd/mm/yyyy"
sample_text = c("this is a test. please convert the date 24/03/2024 and 31/01/2019.",
                "my b-day is on 02/01/2003, not on 01/11/2000.",
                "The event was held on 23/04/2021 and the next event will be on 05/10/2022.")

# replace "dd/mm/yyyy" with "yyyy-mm-dd"
str_replace_all(sample_text, "(0[1-9]|[1-2][0-9]|3[0-1])/(0[1-9]|1[0-2])/(\\d{4})", "\\3-\\2-\\1")

# (0[1-9]|[1-2][0-9]|3[0-1]): Matches the day. It allows days from 01 to 31.
# (0[1-9]|1[0-2]): Matches the month. It allows months from 01 to 12.
# (\\d{4}): Matches the year. It allows any four digits for the year.

# (\1, \2, \3) represents a capture group from the regular expression pattern. 
# The replacement pattern "\\3-\\2-\\1", swaps the positions of the day, month, and year, 
# effectively changing the format from "dd/mm/yyyy" to "yyyy-mm-dd".



# Write an R code snippet that assigns the string "I am here.  Am I alive" to
# a variable "x" and uses an Escape Sequence to put a newline between the two
# sentences.

# the escape sequence \n corresponds to the newline character
x = "I am here.\nAm I alive"

cat(x) # prints and translates escape sequence \n




# Write an R code snippet that assigns the following string to the variable "y:"
#
# She said, "Hi!"

# escape the quotes in the string \"
y = "She said, \"Hi!\""

cat(y) # prints and translates escape sequence \"



# [TEXT ANSWER] Explain what a Text Encoding is:

# Text encoding is a system that assigns numbers to characters and symbols in order
# to represent text in computers. It allows computers to store, transmit, and display
# textual data. An example is in ASCII, the character "a" maps to the number 97. 



# Write an R code snippet that creates a vector of all containing the words in the string, 
# "He wanted to say hello but was afraid".  Then use the stringr library to locate any 
# occurrences of the string "hello" in your vector.

string = "He wanted to say hello but was afraid"
words = str_split(string, " ") # split a sentence into words
words # list
vector = words[[1]] # index to get the vector of words
vector
str_detect(vector, "hello") # detects whether "hello" appears within the string





# Section "15.8 Corpus Analytics" of the reader contains a tutorial on performing
# corpus analytics on a Document Term Matrix of 19th Century novels.  A Document Term
# Matrix is a matrix that contains information about the number of times that a word 
# appears in each text in a corpus.  In class, we calculated the word frequencies for
# the novel _Wuthering Heights_.  The "data" folder in the Files area of Canvas for 
# this course contains a file names dtm.rds which holds this type of count information
# for every normalized text in the collection of novels we worked with in class. 
# First, download that file to your couse working directory.   Then, recreate a working
# version of the code in section 15.8 of the reader below.  Note that before you can 
# use the code in that section you will need to read dtm.rds file into the dtm variable
# so that the data ih the DTM is available to the rest of the code.

# loading files
dtm = readRDS("~/sts115_ktu/dtm.rds")
manifest = read.csv("~/sts115_ktu/C19_novels_manifest.csv")
cleaned_corpus = readRDS("~/sts115_ktu/C19_novels_cleaned.rds")


# Number of columns in the Document Term Matrix (the vocabulary size)
dtm$ncol

# Number of rows in the DTM (the number of documents this matrix represents):
dtm$nrow

# the document names are just numbers in a vector
dtm$dimnames$Docs

# they’re ordered according to the sequence in which the corpus
# was originally created. This means we can use our metadata 
# from manifest to associate a document with its title
dtm$dimnames$Docs = manifest$title
dtm$dimnames$Docs

# get a high-level view of the corpus.
inspect(dtm)

# terms that appear more than 1,000 times in the corpus
findFreqTerms(dtm, 1000)

# which words rise and fall in usage alongside a given word
# third argument position of this function is a cutoff for the strength of a correlation.
findAssocs(dtm, "boat", .85)

# Here’s “writing” (there are a lot of terms, so limit to 15):
writing = findAssocs(dtm, "writing", .85)
writing[[1]][1:15]


# Corpus Term Counts

#it would be useful to get a full count of all the terms in the corpus
# transform the DTM into a matrix and then a data frame.
term_counts = as.matrix(dtm)
term_counts = data.frame(sort(colSums(term_counts), decreasing = TRUE))
term_counts = cbind(newColName = rownames(term_counts), term_counts)
colnames(term_counts) <- c("term", "count")

# Load ggplot2 library
library(ggplot2)

# plot the top 50 terms in these counts that will cover the entire corpus
ggplot(
  data = term_counts[1:50, ], 
  aes(
    x = fct_reorder(term, -count), # call fct_reorder() in the aes() field of ggplot to sort words in the descending order of their term frequency
    y = count)
) +
  geom_bar(stat = "identity") + 
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) + 
  labs(
    title = "Top 50 words in 18 Nineteenth-Century Novels", 
    x = "Word", 
    y = "Count"
  )


# tf–idf Scores (a measure of uniqueness for the terms it contains)

# using the tm package, certain functions may expect full documents rather than tokenized versions. 
# So if you tokenize your documents for text cleaning purposes, you may need to recombine the tokens 
# back into full documents before using other functions in tm.
cleaned_corpus <- lapply(cleaned_corpus, paste, collapse = " ") # concatenates the tokens of each document back into a single string
# reformat that output as a corpus object
cleaned_corpus <- Corpus(VectorSource(cleaned_corpus))

# implements tf–idf scores by making a Document Term Matrix using the tm package
dtm_tfidf <- DocumentTermMatrix(
  cleaned_corpus,
  control = list(weighting = weightTfIdf)
)
dtm_tfidf$dimnames$Docs <- manifest$title
# inspect(dtm_tfidf)


# plot the top terms in our corpus using their tf–idf scores
tfidf_counts = as.matrix(dtm_tfidf)
tfidf_counts = data.frame(sort(colSums(tfidf_counts), decreasing = TRUE))
tfidf_counts = cbind(newColName = rownames(tfidf_counts), tfidf_counts)
colnames(tfidf_counts) = c("term", "tfidf")

ggplot(
  data = tfidf_counts[1:50, ], 
  aes(
    x = fct_reorder(term, -tfidf), 
    y = tfidf)
) +
  geom_bar(stat = "identity") + 
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ) + 
  labs(
    title = "Words with the 50-highest tf--idf scores in 18 Nineteenth-Century Novels", 
    x = "Word", 
    y = "TF-IDF"
  )

# look at term correlations using tf–idf scores.
# Here’s “boat”
findAssocs(dtm_tfidf, terms = "boat", corlimit = .85)
# Here’s “writing”
findAssocs(dtm_tfidf, terms = "writing", corlimit = .85)

# transpose(switch) the DTM so the documents are our variables (columns) 
# and the corpus vocabulary terms are our observations (or rows). 
# Don’t forget the t
tfidf_df <- as.matrix(dtm_tfidf)
tfidf_df <- as.data.frame(t(tfidf_df))
colnames(tfidf_df) <- manifest$title


# Unique Terms in a Document

# find top most unique terms for a novel
# we can order our rows by the highest value for a given column

# Here’s Dracula
rownames(tfidf_df[order(tfidf_df$Dracula, decreasing = TRUE)[1:50], ])

# Here’s Frankenstein:
rownames(tfidf_df[order(tfidf_df$Frankenstein, decreasing = TRUE)[1:50], ])

# here’s Sense and Sensibility:
rownames(tfidf_df[order(tfidf_df$SenseandSensibility, decreasing = TRUE)[1:50], ])




