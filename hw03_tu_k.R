# To Submit 
# git add filename
# git commit -m 'add a comment'
# git push

# This file contains homework questions for the lecture on 
# Control Structures and Functions.  Questions appear as comments 
# in the file.  Place your answers as executable code immediately 
# following the relevant question.


# QUESTION 1: Assign the value 3 to a variable "x" and write
# a conditional statement that test whether x is less than 5.  
# if it is, print "Yay!" to screen.

# assign 3 to x
x = 3
# if x is less than 5, print "Yay!" to screen
if (x < 5) {
  print("Yay!")
}


# QUESTION 2:  Create two variables "x" and "y" and assign 
# each a numeric value. Create a conditional statement that 
# tests whether the value of a variable "x" is equivalent 
# to the value of variable "y." If the values are equivalent, 
# print "The variables are equal" to screen. If they are not 
# equivalent, print "The variables are not equal" to screen.

# assign each variable a numeric value
x = 3
y = 3

# checks if x and y are equivalent
if (x == y) {
  print("The variables are equal") # prints if x and y are equivalent
  
} else {
  print("The variables are not equal") # prints if x and y are not equivalent
}


# QUESTION 3:  Duplicate the conditional code from above, but 
# change the logic of the conditional so that it tests for 
# conditions in which "x" IS NOT EQUIVALENT" to "y" and print 
# the appropriate message to screen accordingly.

x = 3
y = 4

# checks if x is not equivalent to y
if (x != y) {
  print("The variables are not equal") # prints if x and y are not equivalent
} else {
  print("The variables are equal") # prints if x and y are equivalent
}


# QUESTION 4:  Assign the boolean value TRUE to the variable "x", 
# and then create a conditional statement that tests whether the 
# value of a variable "x" is TRUE or FALSE. If the value is true, 
# print "X is true" to screen. If false print "X is false" to screen.

# assign x to true
x = TRUE

# checks if x is true
if (x == TRUE){
  print("X is true") # prints if x is true 
} else {
  print("X is false") # prints if x is false
}


# QUESTION 5: Write a "for" loop that iterates through the 
# values 1 to 10 and prints the iteration number to screen 
# during each loop.

# iterates through every element in the vector 1,2,3,...,9,10
for (i in 1:10) {
  print(i) # prints each element
}


# Question 6: Assume that you want to create a loop that executes 
# exactly 10 times. Assign the value 1 to "x" and then write a "while" 
# loop that iterates based on a test of the value of "x" and for each 
# loop prints the value of "x" to the screen. 
#
# The printed output should look like:
#
# 1 2 3 4 5 6 7 8 9 10
#
# Note that depending on your browser the numbers may print to the same 
# line or each on a new line.

x = 1
# executes code while x is less than or equal to 10
while(x <= 10) {
  print(x)
  x = x + 1 # increments x by 1 
}



# Question 7: Create a list or vector object that contains 
# the following values:
#
# Tesla, Nissan, Harley, Chevy, Indian, MG. 
# 
# Then write code that loops through each item in the list and
# prints the value to screen

# vector
x = c("Tesla", "Nissan", "Harley", "Chevy", "Indian", "MG." )

# prints every iteration in the vector
for(i in x) {
  print(i)
}
 
 
# Question 8: Write code that loops through each item in the list 
# object that you created for Question 3 above and, for each value,
# if the values is "Harley" or "Indian" print, "This is a motorcycle" 
# to screen. Otherwise print, "This is a car" to screen.

x = c("Tesla", "Nissan", "Harley", "Chevy", "Indian", "MG." )
for(i in x) {
  
  # checks if i is Harley or Indian
  if (i == "Harley" || i == "Indian") {
    print("This is a motorcycle") # prints if i is Harley or Indian
  } else {
    print("This is a car") # prints i is not Harley or Indian
  }
}


# Question 9: Assign the values 1-10 to a vector.  Then, loop through
# your vector and print each value to screen unless the value is 5.  (The
# final output of your process should be: 1 2 3 4 6 7 8 9 10)

# assigns the values 1-10 to a vector
v = c(1:10)

# goes through each element in vector v
for (i in v) {
  # checks if i is not 5
  if (i != 5) {
    print(i)
  }
}


# QUESTION 10: Write a function that performs a simple math equation 
# with a variable. Run the function substituting the variable with 
# at least three different values by calling it in a loop. For 
# instance, if you write a function for a variable "x", Use a loop 
# call the function for at least three numbers as "x".

# math function
math_equation = function(x) {
  # multiplies the variable x by 2
   x = x * 2
  return(x)
}

# for every element in 1-3
for(i in 1:3) {
  # calls the math function
  x = math_equation(i)
  print(x) # final print should be 2, 4, 6
}


