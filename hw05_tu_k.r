# emf - excellent work! you can find comments below by searching for "emf"

# Directions:

# This file contains homework questions for the lecture on data forensics
# and statistics. Questions appear as comments in the file. 

# The first four questions are narrative only, meaning you can just write an
# answer and do not need to write computer code. For other questions, please 
# see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# 1. What is a Frequency Distribution? [comprehension]

# A frequency distribution is a visual display that organizes how many times values appear. 
# It can be shown through a table or graph. 


# 2. What is a Relative Frequency Distribution? [comprehension]

# A relative frequency distribution shows the number of times a value appears
# in relation to the total number of values. It is a proportion or a percentage.


# 3. What is Deviation a measure of? [comprehension]

# Deviation is a measure of distance from a point to a mean. 
# It shows the variability or spread of the data points.


# 4. What is Standard Deviation? [comprehension]

# Standard Deviation is the square root of the average squared distance to the mean. 
# It measures how dispersed the data is in relation to the mean.



# 5. Load the Craigslist data and then compute:

# changed to sts115_ktu dircetory in the console
# loads the data into cl
cl = read.csv("cl_rentals.csv")

#
#     a. The number of rows and columns. [code completion + comprehension]
#

# gets the dimensions of the Craigslist data. Displays rows and columns
dim(cl) # 2987 rows   20 columns

#     b. The names of the columns. [code completion + comprehension]

# gets the names of the columns
names(cl)

# "title"        "text"         "latitude"     "longitude"    "city"        
#  "date_posted"  "date_updated" "price"        "deleted"      "sqft"        
#  "bedrooms"     "bathrooms"    "pets"         "laundry"      "parking"     
#  "craigslist"   "shp_place"    "shp_city"     "shp_state"    "shp_county"  


#     c. A structural summary of the data. [code completion + comprehension]

# gives structural summary. It shows the data type for each column, a preview of 
# the first few values and more.
str(cl)

#
#     d. A statistical summary of the data. [code completion + comprehension]

# shows a summary of each column. For numeric columns, it shows things like mean, median.
# For character columns, it shows things like the length and more. 
summary(cl)



# 6. The goal of this exercise is to compute the number of missing values in
#    every column of the Craigslist data.
#
#    a. Write a function called `count_na` that accepts a vector as input and
#       returns the number of missing values in the vector. Confirm that your
#       function works by testing it on a few vectors. 
#.      [code completion + comprehension]
#

# count_na funtion
count_na = function(x) {
  
  # gets total number of NAs in a vector 
  num_na = sum(is.na(x))
  # returns the total number of NAs
  return(num_na)
}

# Test
vector1 = c(1, 1, NA, 2, 3, 3, 4, 4, NA, NA)
vector2 = c("hi", "bye", NA)

# prints the number of NAs in the vectors
print(count_na(vector1)) # outputs 3
print(count_na(vector2)) # outputs 1


#    b. Test your function on the `pets` column from the Craigslist data. The
#       result should be 14. If you get an error or a different result, try
#       part a again.
#       [code completion + comprehension]
# 

# Prints the number of NAs in the "pets" column. 
# Uses the count_na function with the pets column as input
print(count_na(cl$pets)) # outputs 14


#    c. Use an apply function to apply your function to all of the columns in
#       the Craigslist data set. Include the result in your answer.
#       [code completion + comprehension]
#

# uses the sappy function on all the columns. Uses the dataframe and function as arguments. 
sapply(cl, count_na)

# title         text     latitude    longitude         city  date_posted date_updated 
# 0            0            3            3          952            0         1801 
# price      deleted         sqft     bedrooms    bathrooms         pets      laundry 
# 35            0          347           10           10           14            0 
# parking   craigslist    shp_place     shp_city    shp_state   shp_county 
# 0            0           24          650            3            3 


#    d. Which columns have 0 missing values? [comprehension]

# title, text, date_posted, deleted, laundry, parking, and craigslist have 0 missing values



# 7. What time period does this data cover? Hint: convert the `date_posted`
#    column to an appropriate data type, then use the `range` function.
#    [code completion + comprehension]

# load lubridate package 
library(lubridate)

# check type and see first few values
str(cl$date_posted)

# convert from character to date and time 
cl$date_posted = ymd_hms(cl$date_posted)

# class is POSIXct for date times
str(cl$date_posted)

# gets the minimum and maximum dates/times
range(cl$date_posted) # outputs "2021-01-30 09:44:09 UTC" "2021-03-04 13:00:48 UTC"


# The time period of the data goes from 1/3/2021 at 9:44 to 3/4/2021 at 13:00

# emf - good!



# 8. Compute the mean price for each pets category. Based on the means, are
#    apartments that allow pets typically more expensive? Explain, being
#    careful to point out any subtleties in the result.
#    [code completion + comprehension + interpretation]

# converts the pets column into a factor in order to see the categories
observations = levels(factor(cl$pets))
observations

# iterates through each category 
for (i in observations) {
  
# gets the row numbers from the pets column that are the equal to i
row_num_with_obs = which(cl$pets == i)

# uses the price column and indexes with the row numbers that were based on the pets
price_with_num_na = cl$price[row_num_with_obs]
# gets the prices and NAs of a single category
price_with_num_na 

# gets the rows that are not NA
index_num_without_na = which(!is.na(price_with_num_na))

# uses the rows that are not NA as the index to filter out the NAs
prices_with_num = price_with_num_na[index_num_without_na]

# prints the mean price for a level
cat("Mean price of", i, ":", mean(prices_with_num), "\n")

}

# emf - a but hard to tell that you wrote a for loop here - try formatting it so that each new line of code is indented for readability. Can also simplify with something like:
tapply(cl$price, cl$pets, mean, na.rm = TRUE)

# Apartments that allow pets are not always more expensive. 
# Apartments with no pets are more expensive than with cats.
# Apartments with dogs has the highest price and cats have the lowest
# Apartments with dogs and cats is cheaper than with just dogs.
# The results may be this way because the number of apartments for a category may 
# not be the same as the others, which would affect the mean. In other worlds, each category
# could have little data or a lot of data and the amount of data a category has will influence
# the mean price. 
# Also, having a pet is is not the only affect on price. There are other factors to price such as sqft and  
# number of bedrooms, and others. 



# 9. The `sort` function sorts the elements of a vector. For instance, try
#    running this code:
#
   x = c(4, 5, 1)
   sort(x)
#    
#    Another way to sort vectors is by using the `order` function. The order
#    function returns the indices for the sorted values rather than the values
#    themselves:
#
   x = c(4, 5, 1)
   order(x)
#
#    These can be used to sort the vector by subsetting:
#
   x[order(x)]
#    
#    The key advantage of `order` over `sort` is that it can also be used to
#    sort one vector based on another, as long as the two vectors have the same
#    length.
#    
#    Create two vectors with the same length, and use one to sort the elements
#    of the other. Explain how it (should) work.
#    [code completion + comprehension]

# congruent vectors
age = c(20, 5, 10)
name = c("Jack", "Jill", "Bill")

# sorting the names from youngest to oldest
name[order(age)] 

# order(age) will give the indices for the sorted age vector. 
# Using this as the index for the name vector will sort the names from youngest to oldest.
# So name[order(age)] is sorting the name vector based on sorting the age vector



# 10. Use the `order` function to sort the rows of the Craigslist data set
#     based on the `sqft` column. [code completion + comprehension]
#
#     a. Compute a data frame that contains the city, square footage, and price
#        for the 5 largest apartments. [code completion + comprehension]
#

  # indexes the Craigslist data using ordered rows from "sqft" and columns "city", "sqft", "price"
  # na.last = NA removes the NA values
  data = cl[order(cl$sqft, na.last = NA), c("city", "sqft", "price")]
  
  # displays the last 5 rows of the data, which have the largest sqft
  tail(data, n = 5)

  
  
  # done in discussion
  #  # one solution
  # tail(cl[order(cl$sqft, na.last = FALSE), c("city", "sqft", "price")], n = 5)
  # 
  # # another solution
  # head(cl[order(-cl$sqft), c("city", "sqft", "price")], n = 5)
  # 
  # 
  # # easy way to look at data
  # cl_subset = cl[c("city", "sqft", "price")]
  # 
  # 
  # cl_ordered_sqft = order(cl$sqft, decreasing = TRUE)
  # head(cl[cl_ordered_sqft, c("city", "sqft", "price")], 5)
  
  
   
#     b. Do you think any of the 5 square footage values are outliers? Explain
#        your reasoning. [interpretation]
#
  
# The 88,900 sqft value from Sacramento is an outlier because the sqft is dramatically higher 
# than the other sqft values. The other values are in the 2,000s - 8,000s and this Sacramento's 
#  sqft is more than 10 times higher than the rest so it is an outlier.  
   
   
#     c. Do you think any of the 5 square footage values are erroneous
#        (incorrect in the data)? [interpretation]

# The 88,900 sqft value from Sacramento may be incorrect because the sqft is so much higher compared to the rest 
# and it is also the cheapest out of the five which does not make sense. The highest sqft property should not be 
# the cheapest so the sqft value is likely erroneous. 

  
  
  