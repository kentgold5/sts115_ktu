# emf - good job! you can find comments below by searching for "emf"

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


# 1. All of the questions in this homework use the Best in Show data set. 
#      The data is the file `dogs.rds`.

#   a. Load the data set and use R functions to inspect the number of 
#      columns, number of rows, names of columns, and column data types.
#      [code completion + comprehension]

# Reads rds file from the path 
dogs = readRDS("~/sts115_ktu/best_in_show/dogs.rds")

ncol(dogs) # number of columns
nrow(dogs) # number of rows
names(dogs) # names of columns
lapply(dogs,class) # column data types


#   b. Make a scatter plot that shows the relationship between height and
#      weight. In 2-3 sentences, discuss any patterns you see in the plot.
#      [code completion + comprehension + interpretation]

# Load ggplot2 library
library(ggplot2)


ggplot(dogs) + # data frame
  aes(x = height, y = weight) + # axis
  geom_point() + # scatter plot
  labs(title = "Relationship between Height and Weight of Dogs", x = "Height", y = "Weight") # labels
  
# A pattern in the scatter plot is that height and weight generally have a direct relationship.
# If the dog is short, it will weigh less and taller dogs will weigh more.
# As height increases, weight also increases.


#   c. Set the color of the points in the scatter plot from part b to a single 
#      color of your choosing. (Tip: Choose a color from one of the sites 
#      shared in the lesson (e.g. https://coolors.co/palettes/trending))
#      [code completion + comprehension]

ggplot(dogs) + # data frame
  aes(x = height, y = weight) + # axis
  geom_point(color = "#cdb4db") + # setting the points to a light purple color
  labs(title = "Relationship between Height and Weight of Dogs", x = "Height", y = "Weight") # labels



# 2.
#   a. Make a bar plot that shows the number of dogs in each "group" of dogs.
#      [code completion + comprehension]

ggplot(dogs) +  # data frame
  aes(x = group) + # group as the x axis
  geom_bar() + # bar graph 
  labs(x = "Group of Dogs", y = "Number of Dogs", title = "Number of Dogs in Each Group") # labels


#   b. Are any groups much larger or smaller than the others? Describe what your 
#       visualization shows.
#      [interpretation]

# Sporting and terrier are tied for the largest groups and non sporting and toy are tied for the smallest.
# There are no groups that are substantially larger or smaller than the others, meaning there are no extreme outliers
# and has a good range of groups. 


#   c. Fill in the bars based on the size of the dog, and set the position 
#       argument of the bar geometry to the one you think best communicates the 
#       data. Explain why you chose this position.
#      [code completion + comprehension + interpretation]

ggplot(dogs) + # data frame
  aes(x = group, fill = size) + # group as the x axis. Bars are colored based on size.
  geom_bar(position = "dodge") + # Position of bars is side by side
  labs(x = "Group of Dogs", y = "Number of Dogs", title = "Number of Dogs in Each Group") # labels

# This position of setting the groups side-by-side is easier to count and compare between other groups
# There would be more confusion if the colored bars were stacked on top of each other as it would be 
# difficult to count the number of dogs for a particular size and as a result, comparing would be difficult.

# emf - good!  the bars in this plot have some variation in their widths based on how many size categories are included - is there a way to make these more uniform?


# 3.
#   a. Which geometry function makes a histogram? Use the ggplot2 website or
#      cheat sheet to find out.
#      [code completion + comprehension]

# geom_histogram()

#   b. Make a histogram of longevity for the dogs data. How long do most dogs
#      typically live? Explain in 1-2 sentences.
#      [code completion + comprehension + interpretation]

ggplot(dogs) + # data frame
  geom_histogram() + # histogram geometry
  aes(longevity) + # x axis 
  labs(title = "Histogram of Longevity for Dogs", x = "Longevity (years)", y = "Frequency") # label

# 12.5 years has the highest peak frequency so most dogs typically live for 12.5 years. 


#   c. Inside the geometry function for histograms, play around with the bins
#      argument. (e.g. bins = 10, bins = 50). What do you think this is doing?
#      [code completion + comprehension]

ggplot(dogs) + # data frame
  geom_histogram(bins = 50) + # histogram geometry
  aes(longevity) + # x axis 
  labs(title = "Histogram of Longevity for Dogs", x = "Longevity (years)", y = "Frequency") # label

# Bins specify the number of intervals for the x axis into which the data range will be divided for the histogram.
# With a higher bins, the bars of the histogram are smaller and a lower bin makes the bars bigger


# 4.
#   a. Modify your plot from Question 1 so that the shape of the points is
#      determined by the "group" of the dog. [code completion + comprehension]

ggplot(dogs) + # data frame
  aes(x = height, y = weight, color = group, shape = group) + # shape and color determined by the "group"
  geom_point() + # scatter plot
  labs(title = "Relationship between Height and Weight of Dogs", x = "Height", y = "Weight") + # labels
  scale_shape_manual(values = c(16,17,15,3,7,8,11)) # manually setting the shapes. The numbers corresponding to the shapes in the legend
# emf - good!

#   b. Do height and weight effectively separate the different groups of dogs?
#      In other words, are there clear boundaries between the groups in the
#      plot (as opposed to being mixed together)? Are some groups better
#      separated than others?
#      [interpretation]

# The height and weight do not separate the different groups of dogs because there are groups that are mixed into 
# the boundaries of other groups. The working dogs are the most separated from the other groups' boundaries but there is still some overlap.

#   c. How might you improve the readability of this graph in order to visualize
#      this potential relationship more clearly?
#      [interpretation]

# Instead of leaving all the shapes to be one color, I also made each each shape a different color 
# using the code, color = group, in the aes to make it much easier to read. 


# 5. In a paragraph, answer the following questions for the “Best in Show” 
#    visualization (https://informationisbeautiful.net/visualizations/best-in-show-whats-the-top-data-dog/) 
#    that was built using the dogs dataset.

#    a. Who do you think is the intended audience for this data visualization? 
#        How do you think that could influence data collection, metrics calculations, 
#        and graphics choices?
#       [interpretation]

# I think this data visualization is intended for those who are interested in dogs to give them knowledge 
# on the popularity of dogs. Due to this, the graphical choices do not present numeric data and only colored visuals 
# to appeal to those who like dogs. The data collection and metric calculations on popularity are based on the common aspects for 
# wanting to own a dog, such as breed and group type, size, and intelligence.

#    b. Who/what is included in this data visualization and who is left out? 
#        What do you think the impact of that decision could be on conclusions drawn
#        from viewers of the data visualization? 
#       [interpretation]

# People who like dogs and are curious about their popularity are included in the data.
# Aspects that people care about like dog breed, group, intelligence, size, and popularity 
# are included in the visualization. Other factors like grooming, price, food costs and more are not
# presented in the visualization which may give viewers a one sided perspective on the popularity of dogs
# that only considers a few aspects. 


#    c. What could the potential impact of this visualization be on those 
#       who are left-out? [interpretation]

# The impact of the visualization on those who are left-out would be that this visualization 
# does not help the people who want to know about the other factors, like grooming or price.
# If people are looking for aspects of dogs that are not shown, then this visual is not helpful to them. 


# 6. Select your favorite data visualization from https://viz.wtf/ 
# (that was not featured during class or in the reader). 

#   a. Type the direct url to the viz you selected here:
# https://viz.wtf/image/639589038118125568 

#   b. Describe in a few sentences the "data story" you think that this visualization 
#       is trying to tell.

# The data story is trying to answer and find out, what is the shoe color that is the most worn or 
# what is the distribution of shoe colors that people wear. This visualization could be for shoe markets 
# wanting to know which color is preferred or is popular among consumers. They can use this knowledge to sell what color people 
# prefer wearing the most like knowing that black shoes are worn the most so they sell more black shoes .

#   c. In a paragraph, what makes this a "bad" visualization? Evaluate the visualization 
#       based on the visualization principles and perception rules discussed in class 
#       (i.e., Gestalt principles, plot type, accessibility, critical reading, etc.), 
#       and suggest a few changes to improve the graphic.

# What makes this a "bad" visualization is that the bar colors do not correspond to the shoe color in the x axis.

#emf - could engage more with the visualization principles and perception rules discussed in class 

# Adding a more specific title like shoe color frequency from who or what group of people would help with context.
# Adding textures in the bars would help those who are colorblind.
# Adding a y axis label would help with specificity. 

#   d. Describe in 1-2 sentences one thing that this visualization actually already does well.

# This visualization is great for seeing the distribution of shoe colors. You can see which is the most
# and least worn shoe colors and it is easy to compare colors. 



# 7. Look at the plot posted with this assignment on Canvas.
#    a. Identify the marks and channels in this plot. Write them out for this answer

# The marks are points.
# The channels are position, shapes, and color

#    b. Write the code to generate this plot. (Hint: start with identifying the 
#        variables on each axis, then think about the types of channels).

ggplot(dogs) + # data frame 
  aes(longevity, lifetime_cost, color = group, shape = group) + # x,y axis. color and shape based on group
  geom_point() + # scatter plot
  labs(title = "Dogs", x = "Longevity (years)") # labels for only x and title 


#    c. Propose 4 improvements to the plot based on best practices.

# remove chart junk. 
# make working dogs appear in the plot. 
# add shapes and colors for color blind people.
# rename the y variable.
# rename title. 

#    d. Modify the code to implement at least two of those changes.

ggplot(dogs) + # data frame
  aes(longevity, lifetime_cost, color = group, shape = group) +  # x,y axis. color and shape based on group
  geom_point() + # scatter plit
  labs(title = "The Lifetime Cost of Dogs", x = "Longevity (years)", y = "Lifetime Cost ($)") + # adds better title and renames y axis
  # manually set colors that are friendly to colorblind people
  scale_color_manual(values=c("#fef0d9", "#fdd49e", "#fdbb84", "#fc8d59", "#ef6548","#d7301f","#990000")) + 
  scale_shape_manual(values = c(16,17,15,3,7,8,11)) + # manually sets the shape for each group of dogs
  theme_minimal() # removes unnecessary gray background elements

# emf - great!

