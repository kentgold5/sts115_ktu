# emf - excellent work! Great answers and annotations.

# Directions:

# This file contains homework questions for the lecture on working with files
# and data exploration. Questions appear as comments in the file. 

# Please see the Grading Criteria Canvas Page for specific guidance on what
# we expect from you regarding assignment responses.

# Once you have completed the assignment, follow the Submission Instructions 
# on Canvas Pages section to add, commit, and push this to your GitHub repository. 

# Some questions have multiple parts - make sure to read carefully and
# answer all of them. The majority of points lost in homework come from
# careless skipping over question parts.  

###############################################################################

# 1. Write out the file extension and explain what it means for the following
#    files: [comprehension]
#
#       a. `myscript.py`
#
#       b. `/home/arthur/images/selfie.jpg`
#
#       c. `~/Documents/data.csv`


# a. `myscript.py` has the extension .py which indicates that that the file is a program or script in python.

# b. `/home/arthur/images/selfie.jpg` has the extension .jpg which indicates that the file is an image because .jpg is a widely used image file format. 

# c. `~/Documents/data.csv` has the extension .csv which indicates that the file is a comma separated values file. It is a text file that records tabular data.


###############################################################################

# 2. Which command line utility can be used to determine the type of a file? 
# [code completion]

# There is the file command that can give information about the type of the file on the terminal.
# file file_name


###############################################################################

# 3. Why is it a bad idea to explicitly call the `setwd` function within an R
#    script? [comprehension]

# It is bad to call `setwd` in the R script because it makes the code more difficult 
# to understand and because it is less portable to other computers as the paths are not the same for every device. 


###############################################################################

# 4. List one advantage and one disadvantage for each of these formats:
# [comprehension]
#   
#     a. RDS files
#
#     b. CSV files

# An advantage of RDS files is that it can be quickly loaded in and out of R. 
# A disadvantage is that RDS files are only used in R so others need to know and have R. 

# An advantage of CSV files is that it is tabular and text. 
# A disadvantage is that you cannot save complex data like images in a CSV file. 


###############################################################################

# 5. Why doesn't R automatically load every installed package when it starts?
# [comprehension]

# It it unnecessary to load every package because some packages might not even be used 
# and it would be a waste of computation time. 
# You have to load the packages that are necessary for the code to run to be efficient.


###############################################################################

# 6. Load the dogs data from the `dogs.rds` file provided in lecture.
#

# Loaded the dogs data from `dogs.rds`
dogs = readRDS("~/sts115_ktu/best_in_show/dogs.rds")


#     a. How many missing values are in the `height` column? 
#       [code completion + comprehension]

# indexing the dogs data frame to find the rows that are NA from the column "height"
rows_with_na = dogs[is.na(dogs$height), "height"]   

# finds the length of the vector containing the NAs
length(rows_with_na) # outputs 13

# There are 13 missing values in the `height` column


# other methods done in discussion
# nrow(dogs[is.na(dogs$height), ])
# dim(dogs[is.na(dogs$height), ])
# sum(is.na(dogs$height))



#     b. Think of a strategy to check the number of missing values in every
#        column using no more than 3 lines of code. Hint: think about last
#        week's lecture. Explain your strategy in words. 
#       [code completion + comprehension]

# iterates through each column name in dogs data frame
for (i in names(dogs)) {  
  # finds the rows with NA in the current column and prints the the number of NAs
  print(length(which(is.na(dogs[ , i]))))  
}

# Strategy
# I used a for loop to iterate through every column in the dogs data frame.
# There is dogs[ , i] which indexes all rows from column i. is.na(dogs[ , i]))) creates a logical vector from column i that is used as a condition. 
# Then I used the which statement that finds when the condition is true and stores it in rows_with_na.
# rows_with_na stores all the NA values that are in a column, so I print the length of rows_with_na to show the number of NAs in that specific column.

  
# other method done in discussion
# for (i in 1:ncol(dogs)) {
#   print(sum(is.na(dogs[ , i])))
#   
# }
  


#     c. Which column has the most missing values? Try to solve this by
#        implementing your strategy from part b. If that doesn't work, you can
#        use the `summary` function to get the number of missing values in each
#        column as well as a lot of other information (we'll discuss this
#        function more next week).
#       [code completion + comprehension]

# initially set the highest number of NAs to be zero
highest_num_na = 0

# iterates through each column name
for (i in names(dogs)) {  
  # finds the rows with NA in the current column
  rows_with_na = which(is.na(dogs[ , i]))  
  # prints the number of NAs in the current column
  print(length(rows_with_na))  
  
  # number of of NAs
  num_of_na = length(rows_with_na)
  # if the current column has more NAs than the previous highest number of NAs
  if (num_of_na > highest_num_na) {
    # set the current number of NAs to be the highest
    highest_num_na = num_of_na 
    # keep track of the column name that has the most NAs
    column_name = i
  }
}

print(column_name) # prints column name with the most NAs
print(highest_num_na) # prints the highest number of NAs  

# The column with the most missing values is the "weight" column with 86 NAs


###############################################################################

# 7. Use indexing to get the subset of the dogs data which only contains large
#    dogs that are good with kids (the category `high` in the `kids` column
#    means good with kids). [code completion + comprehension]


# indexes rows from columns "size" and "kids" that are not NA, and are large in the size column and high in the kids column.
# shows all columns 
dogs[!is.na(dogs$size) & !is.na(dogs$kids) & dogs$size == "large" & dogs$kids == "high", ]


###############################################################################

# 8. With the dogs data:
#
#     a. Write the condition to test which dogs need daily grooming (the result
#        should be a logical vector). Does it contain missing values? 
#       [code completion + comprehension]
#

# creates a logical vector by using an equivalent condition on the grooming column to show which dogs need daily grooming
groom_daily = (dogs$grooming == "daily")
print(groom_daily)


# checks if daily has any NAs. This can be helpful if NA is hard to see visually when vector is printed 
contains_na = any(is.na(groom_daily))
print("contains NA?")
# results in true or false 
print(contains_na)

# The logical vector does contain missing values because there are NAs in the grooming column.



#     b. Use the condition from part a to get the subset of all rows containing
#        dogs that need daily grooming. How many rows are there?
#       [code completion + comprehension]
#

# creates a logical vector by using an equivalent condition on the grooming column to show which dogs need daily grooming
groom_daily = (dogs$grooming == "daily")
groom_daily

# indexes dogs with the conditions of getting True for the row is "daily"
groom_daily = dogs[groom_daily, ] # needs "!is.na(groom_daily) & groom_daily" in the rows
groom_daily
# finds the number of rows
nrow(groom_daily) # output is 83

# There are 83 rows.



#     c. Use the `table` function to compute the number of dogs in each
#        grooming category. You should see a different count than in part b for
#        daily grooming. What do you think is the reason for this difference?
#       [code completion + interpretation]
#

# table function on grooming column
table(dogs$grooming)

# output 
# daily  weekly monthly 
# 23      88       1

# The output here is 23 for daily. In part b, there were 83 rows due to the NA values. 
# NA values were present because there was no check for them when they should have been excluded. 
# This code "!is.na(groom_daily) & groom_daily" should be used to index the rows to make sure there are no NA values.



#     d. Enclose the condition from part a in a call to the `which` function,
#        and then use it to get the subset of all rows containing dogs that
#        need daily grooming. Now how many rows are there? Does the number of
#        rows agree with the count in part c?
#       [code completion + comprehension]

# which finds the row numbers when the condition is true
groom_daily = which(dogs$grooming == "daily")
groom_daily 
# the row condition is a which statement. Index by position 
groom_daily = dogs[groom_daily, ]
groom_daily
# gets number of rows 
nrow(groom_daily) # outputs 23

# There are 23 rows which agrees with the count in part c because which will follow the condition, 
# which will not include NA values.


###############################################################################

# 9. Compute a table that shows the number of dogs in each grooming category
#    versus size. Does it seem like size is related to how often dogs need to
#    be groomed? Explain your reasoning. [code completion + interpretation]

# creates a table of grooming frequency versus the size of the dog
table(dogs$grooming, dogs$size)

# Size does not seem to relate much on how often dogs need to be groomed. 
# While there are more small dogs that need to be groomed daily, it is not more by much in comparison to the other sizes of dogs.
# A similar situation can be said about how there are more large dogs that groom weekly, but not by much.

# A majority of dogs, of all sizes, groom weekly and there are not many dogs that groom monthly.
# There does not seem to be any striking trends that show that size relates to grooming frequency.


###############################################################################

# 10. Compute the number of dogs in the `terrier` group in two different ways:
#
#     a. By making a table from the `group` column. 
#       [code completion + comprehension]
#

# creates a table from the column "group" that shows how many times each element appears
table = table(dogs$group)
table

# indexing by the name "terrier" to get the count
num_terrier = table["terrier"]
print(num_terrier) # number of terriers = 28


#     b. By getting a subset of only terriers and counting the rows.
#       [code completion + comprehension]
#

# indexes the rows in "group" that are not NA and is a terrier with all columns. 
num_terrier = dogs[!is.na(dogs$group) & dogs$group == "terrier", ]
num_terrier # prints subset

# counts the number of rows 
nrow(num_terrier) # outputs 28


#     c. Computing the table is simpler (in terms of code) and provides more
#        information. In spite of that, when would indexing (approach b) be more
#        useful? [comprehension + interpretation]

# Indexing would be more useful when you need to see the other data like the other column data.
# You can choose to make a subset of the data frame and choose specific rows and columns to see. 
# Once you get the subset, you can do further analysis on that data like finding the number of rows that was in part b.  
# For a table, it only shows how many times each element appears which may not be as informative as indexing.   




