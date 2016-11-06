library(ggplot2)

str(mtcars)

# A scatter plot has been made for you
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Replace ___ with the correct vector
ggplot(mtcars, aes(x = wt, y = mpg, col = disp)) +
  geom_point()

# Replace ___ with the correct vector
ggplot(mtcars, aes(x = wt, y = mpg, size = disp)) +
  geom_point()


# Explore the diamonds data frame with str()
str(diamonds)

# Add geom_point() with +
ggplot(diamonds, aes(x = carat, y = price)) + geom_point()


# Add geom_point() and geom_smooth() with +
ggplot(diamonds, aes(x = carat, y = price)) + geom_point() + geom_smooth()


# The plot you created in the previous exercise
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

# Copy the above command but show only the smooth line
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_smooth()


# Copy the above command and assign the correct value to col in aes()
ggplot(diamonds, aes(x = carat, y = price, col=clarity)) +
  geom_smooth()


# Keep the color settings from previous command. Plot only the points with argument alpha.
ggplot(diamonds, aes(x = carat, y = price, col=clarity)) +
  geom_point(alpha = 0.4) 


# Create the object containing the data and aes layers: dia_plot
dia_plot <- ggplot(diamonds, aes(x= carat, y=price))

# Add a geom layer with + and geom_point()
dia_plot + geom_point()

# Add the same geom layer, but with aes() inside
dia_plot + geom_point(aes(col = clarity) )



set.seed(1)

# The dia_plot object has been created for you
dia_plot <- ggplot(diamonds, aes(x = carat, y = price))

# Expand dia_plot by adding geom_point() with alpha set to 0.2
dia_plot <- dia_plot + geom_point(alpha = 0.2)


# Plot dia_plot with additional geom_smooth() with se set to FALSE
dia_plot + geom_smooth(se = FALSE)

# Copy the command from above and add aes() with the correct mapping to geom_smooth()
dia_plot + geom_smooth( aes(col = clarity), se = FALSE )


##CHAPTER 2
# Plot the correct variables of mtcars
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

# Change cyl inside mtcars to a factor
mtcars$cyl <- as.factor(mtcars$cyl)

# Make the same plot as in the first instruction
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)


# Basic plot
mtcars$cyl <- as.factor(mtcars$cyl)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)

# Use lm() to calculate a linear model of mpg described by wt and save it as carModel
carModel <- lm(mpg ~ wt, data = mtcars)

# Call abline() with carModel as first argument and set lty to 2
abline(carModel, lty = 2)

# Plot each subset efficiently with lapply
# You don't have to edit this code
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})

# This code will draw the legend of the plot
# You don't have to edit this code
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")


# Convert cyl to factor (don't need to change)
mtcars$cyl <- as.factor(mtcars$cyl)

# Example from base R (don't need to change)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)
abline(lm(mpg ~ wt, data = mtcars), lty = 2)
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")

# Plot 1: add geom_point() to this command to create a scatter plot
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point()  # Fill in using instructions Plot 1

# Plot 2: include the lines of the linear models, per cyl
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() + # Copy from Plot 1
  geom_smooth(method = "lm", se = FALSE)   # Fill in using instructions Plot 2

# Plot 3: include a lm for the entire dataset in its whole
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() + # Copy from Plot 2
  geom_smooth(method = "lm", se = FALSE) + # Copy from Plot 2
  geom_smooth( method = "lm", se = FALSE, lty = 2, aes(group = 1))   # Fill in using instructions Plot 3


# Option 1
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point() +
  geom_point(aes(x = Petal.Length, y = Petal.Width), col = "red")

# Option 2: best 1. ggplot legend, layers...
ggplot(iris.wide, aes(x = Length, y = Width, col = Part)) +
  geom_point()


# Consider the structure of iris, iris.wide and iris.tidy (in that order)
str(iris)
str(iris.wide)
str(iris.tidy)

# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.tidy, aes(x = Species, y = Value, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Measure)


###############
#########################
# Load the tidyr package
library(tidyr)

# Fill in the ___ to produce to the correct iris.tidy dataset
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")


####
# Consider the head of iris, iris.wide and iris.tidy (in that order)
head(iris)
head(iris.wide)
head(iris.tidy)

# Think about which dataset you would use to get the plot shown right
# Fill in the ___ to produce the plot given to the right
ggplot(iris.wide, aes(x = Length, y = Width, col = Part)) +
  geom_jitter() +
  facet_grid(. ~ Species)

###
# Load the tidyr package
library(tidyr)

# Add column with unique ids (don't need to change)
iris$Flower <- 1:nrow(iris)

# Fill in the ___ to produce to the correct iris.wide dataset
iris.wide <- iris %>%
  gather(key, value, -Species, -Flower) %>%
  separate(key, c("Part", "Measure"), "\\.") %>%
  spread(Measure, value)

####CHAPTER 3: AESTHETICS###
# mtcars$cyl <- as.factor(mtcars$cyl)

# Map cyl to y
ggplot(mtcars, aes( x = mpg, y = cyl) ) + geom_point()


# Map cyl to x
ggplot(mtcars, aes( y = mpg, x = cyl) ) + geom_point()


# Map cyl to col
ggplot(mtcars, aes( x = wt,y = mpg, col = cyl) ) + geom_point()


# Change shape and size of the points in the above plot
ggplot(mtcars, aes(x = wt,y = mpg, col = cyl)) + geom_point( shape = 1, size = 4) 


# Given from the previous exercise
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

# Map cyl to fill
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) + geom_point()

# Change shape, size and alpha of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 16, size = 6, alpha = 0.6)

#Notice that mapping a categorical variable onto fill doesn't change the colors, although a legend is generated! This is because the default shape for points only has a color attribute and not a fill attribute. Use fill when you have another shape (such as a bar), or when using a point that does have a fill and a color attribute, such as shape = 21, which is a circle with an outline. Any time you use a solid color, make sure to use alpha blending to account for over plotting. 

# Map cyl to size
ggplot(mtcars, aes( x = wt, y = mpg, size = cyl) ) + geom_point( )

# Map cyl to alpha
ggplot(mtcars, aes( x = wt, y = mpg, alpha = cyl) ) + geom_point( )

# Map cyl to shape 
ggplot(mtcars, aes( x = wt, y = mpg, shape = cyl) ) + geom_point( )

# Map cyl to labels
ggplot(mtcars, aes( x = wt, y = mpg, label = cyl) ) + geom_text()


# Define a hexadecimal color
my_color <- "#123456"

# Set the color aesthetic 
ggplot(mtcars, aes( x = wt, y = mpg, col = cyl) )  + geom_point()

# Set the color aesthetic and attribute 
ggplot(mtcars, aes( x = wt, y = mpg, col = cyl) )  + geom_point(color = my_color)

# Set the fill aesthetic and color, size and shape attributes
ggplot(mtcars, aes( x = wt, y = mpg, fill = cyl) )  + 
  geom_point(color = my_color, size = 10, shape = 23)

##Notice that if an aesthetic and an attribute are set with the same argument, the attribute takes precedence. Once again, we see that the attribute needs to match the shape and geom, the fill aesthetic (or attribute) will only work with certain shapes. 

# Expand to draw points with alpha 0.5
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(alpha = 0.5)

# Expand to draw points with shape 24 and color yellow
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, color = 'yellow')

# Expand to draw text with label x, color red and size 10
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_text( label = 'x', color = 'red', size = 10)


# Map mpg onto x, qsec onto y and factor(cyl) onto col
ggplot(mtcars, aes( x = mpg, y = qsec, col = factor(cyl) ) ) +
  geom_point()

# Add mapping: factor(am) onto shape
ggplot(mtcars, aes( x = mpg, y = qsec, col = factor(cyl),shape = factor(am) ) ) +
  geom_point( )

# Add mapping: (hp/wt) onto size
ggplot(mtcars, aes( x = mpg, y = qsec, col = factor(cyl), shape = factor(am), size = (hp/wt) ) ) +
  geom_point()


###########Positions Aes##
# The base layer, cyl.am, is available for you
#cyl.am <- ggplot(mtcars, aes(x = factor(cyl), fill = factor(am)))
# Add geom (position = "stack" by default)
cyl.am + geom_bar()

# Fill - show proportion
cyl.am + 
  geom_bar(position = "fill")  

# Dodging - principles of similarity and proximity
cyl.am +
  geom_bar(position = "dodge") 

# Clean up the axes with scale_ functions
val = c("#E41A1C", "#377EB8")
lab = c("Manual", "Automatic")
cyl.am +
  geom_bar(position = "dodge") +
  scale_x_discrete( "Cylinders") + 
  scale_y_continuous("Number") +
  scale_fill_manual("Transmission", 
                    values = val,
                    labels = lab) 


# Add a new column called group
mtcars$group <- 0

# Create jittered plot of mtcars: mpg onto x, group onto y
ggplot(mtcars, aes(x = mpg, y = group)) + geom_jitter()

# Change the y aesthetic limits
ggplot(mtcars, aes(x = mpg, y = group)) + 
  geom_jitter() + 
  scale_y_continuous(limits = c(-2, 2) )


# Basic scatter plot: wt on x-axis and mpg on y-axis; map cyl to col
ggplot(mtcars, aes( y = mpg, x = wt, col = cyl ) )+
  geom_point(size = 4)

# Hollow circles - an improvement
ggplot(mtcars, aes( y = mpg, x = wt, col = cyl ) ) + 
  geom_point(size = 4, shape = 1)

# Add transparency - very nice
ggplot(mtcars, aes( y = mpg, x = wt, col = cyl) ) + 
  geom_point( size = 4, alpha = 0.6)


#library(ggplot2)
# Scatter plot: carat (x), price (y), clarity (col)
ggplot(diamonds, aes( y = price, x = carat, col = clarity) ) +
  geom_point()

# Adjust for overplotting
ggplot(diamonds, aes( y = price, x = carat, col = clarity) ) +
  geom_point(alpha = 0.5)

# Scatter plot: clarity (x), carat (y), price (col)
ggplot(diamonds, aes( col = price, y = carat, x = clarity) ) +
  geom_point(alpha = 0.5)

# Dot plot with jittering
ggplot(diamonds, aes( col = price, y = carat, x = clarity) ) +
  geom_point(position = "jitter", alpha = 0.5)



#######CHAPTER 4: GEOMETRIES################

# The dataset mtcars is available for you
#mtcars#cyl <- as.factor(mtcars$cyl)

# Plot the cyl on the x-axis and wt on the y-axis
ggplot(mtcars, aes(x = cyl, y = wt) ) + geom_point()

# Use geom_jitter() instead of geom_point()
ggplot(mtcars, aes(x = cyl, y = wt) ) + geom_jitter()

# Define the position object using position_jitter(): posn.j
posn.j <- position_jitter( width = 0.1)

# Use posn.j in geom_point()
ggplot(mtcars, aes(x = cyl, y = wt) ) + 
  geom_point( position = posn.j)


# Examine the structure of Vocab
str(Vocab)

# Basic scatter plot of vocabulary (y) against education (x). Use geom_point()
ggplot(Vocab, aes(x = education, y = vocabulary) ) + geom_point()

# Use geom_jitter() instead of geom_point()
ggplot(Vocab, aes(x = education, y = vocabulary) ) + geom_jitter()

# Using the above plotting command, set alpha to a very low 0.2
ggplot(Vocab, aes(x = education, y = vocabulary) ) + 
  geom_jitter( alpha = 0.2)

# Using the above plotting command, set the shape to 1
ggplot(Vocab, aes(x = education, y = vocabulary) ) + 
  geom_jitter( alpha = 0.2, shape = 1)


# Make a univariate histogram
ggplot(mtcars, aes( x = mpg) ) + geom_histogram()

# Change the bin width to 1
ggplot(mtcars, aes( x = mpg) ) + geom_histogram(binwidth = 1)

# Change the y aesthetic to density
ggplot(mtcars, aes( x = mpg) ) + 
  geom_histogram(aes(y = ..density..), binwidth = 1)

# Custom color code
myBlue <- "#377EB8"

# Change the fill color to myBlue
ggplot(mtcars, aes( x = mpg) ) + 
  geom_histogram(aes(y = ..density..), binwidth = 1, fill = myBlue)

#mtcars$am <- as.factor(mtcars$am)
#mtcars$cyl <- as.factor(mtcars$cyl)
# Draw a bar plot of cyl, filled according to am = as.factor(mtcars$am)
ggplot(mtcars, aes( x = cyl, fill = am ) ) + geom_bar( )

# Change the position argument to stack
ggplot(mtcars, aes( x = cyl, fill = am ) ) + 
  geom_bar( position = "stack")

# Change the position argument to fill
ggplot(mtcars, aes( x = cyl, fill = am ) ) + 
  geom_bar( position = "fill")

# Change the position argument to dodge
ggplot(mtcars, aes( x = cyl, fill = am ) ) + 
  geom_bar( position = "dodge")

# Draw a bar plot of cyl, filled according to am (factors)
ggplot(mtcars, aes( x = cyl, fill = am) ) + geom_bar()

# Change the position argument to "dodge"
ggplot(mtcars, aes( x = cyl, fill = am) ) + 
  geom_bar(position = "dodge")

# Define posn_d with position_dodge()
posn_d <- position_dodge(width = 0.2)

# Change the position argument to posn_d
ggplot(mtcars, aes( x = cyl, fill = am) ) + 
  geom_bar(position = posn_d)

# Use posn_d as position and adjust alpha to 0.6
ggplot(mtcars, aes( x = cyl, fill = am) ) + 
  geom_bar(position = posn_d, alpha = 0.6)


# A basic histogram, add coloring defined by cyl 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1)

# Change position to identity 
ggplot(mtcars, aes(mpg, fill = cyl)) +
  geom_histogram(binwidth = 1, position = "identity")

# Change geom to freqpoly (position is identity by default) 
ggplot(mtcars, aes(mpg, col = cyl)) +
  geom_freqpoly(binwidth = 1)


#?brewer.pal
# Example of how to use a brewed color palette
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")

# Use str() on Vocab to check out the structure: factors educ and vocab
str(Vocab)

# Plot education on x and vocabulary on fill
# Use the default brewed color palette (warning)
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer()

# Final plot of last exercise
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer()

# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues")

# Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11) )

# Basic histogram plot command
ggplot(mtcars, aes(mpg)) + 
  geom_histogram(binwidth = 1)

# Expand the histogram to fill using am
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1)

# Change the position argument to "dodge"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "dodge")

# Change the position argument to "fill"
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "fill")

# Change the position argument to "identity" and set alpha to 0.4
ggplot(mtcars, aes(mpg, fill = am)) + 
  geom_histogram(binwidth = 1, position = "identity", alpha = 0.4)

# Change fill to cyl
ggplot(mtcars, aes(mpg, fill = cyl)) + 
  geom_histogram(binwidth = 1, position = "identity", alpha = 0.4)



##Lines##
# Print out head of economics
head(economics)

# Plot unemploy as a function of date using a line plot
ggplot(economics, aes(x = date, y = unemploy)) +
  geom_line()

# Adjust plot to represent the fraction of total population that is unemployed
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line()


# Expand the following command with geom_rect() to draw the recess periods
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line() +
  geom_rect(data = recess, inherit.aes = FALSE, aes(xmin = begin, xmax = end,
       
                                                                                                 ymin = -Inf, ymax = +Inf), fill = "red", alpha = 0.2 )

#library(tidyr)
# Check the structure as a starting point
str(fish.species)

# Use gather to go from fish.species to fish.tidy
fish.tidy <- gather(fish.species, Species, Capture, -Year)


# Recreate the plot shown on the right
ggplot(fish.tidy, aes(x = Year, y = Capture, col = Species)) + geom_line()
#group = Species or col = Species




#############CHAPTER 5: Qplot and wrap-up###############
# The old way (shown)
plot(mpg ~ wt, data = mtcars)

# Using ggplot:
ggplot(mtcars, aes(x= wt, y = mpg) ) + geom_point()


# Using qplot:
qplot( wt, mpg, data = mtcars)


# basic scatter plot:
qplot(wt, mpg, data = mtcars)

# Categorical:
# cyl
qplot(wt, mpg, data = mtcars, size = cyl)

# gear
qplot(wt, mpg, data = mtcars, size = gear)

# Continuous
# hp
qplot(wt, mpg, data = mtcars, col = hp)

# qsec
qplot(wt, mpg, data = mtcars, col = qsec)


# qplot() with x only -> bar plot
qplot( factor(cyl), data = mtcars)

# qplot() with x and y
qplot( factor(cyl), factor(vs), data = mtcars)

# qplot() with geom set to jitter manually
qplot( factor(cyl), factor(vs), data = mtcars, geom= "jitter")


# Make a dot plot with ggplot
#ggplot(mtcars, aes(cyl, wt, fill = factor(am)))
ggplot(mtcars, aes(cyl, wt, fill = factor(am))) +
  geom_dotplot(stackdir = "center", binaxis = "y")

# qplot with geom "dotplot", binaxis = 
qplot( cyl, wt, fill = factor(am), data = mtcars, 
       geom= "dotplot", stackdir = "center", binaxis = "y")



# ChickWeight is available in your workspace

# Check out the head of ChickWeight
head(ChickWeight)

# Use ggplot() for the second instruction
ggplot(ChickWeight, aes( x = Time, y = weight) ) +
  geom_line(aes( group = Chick) )


# Use ggplot() for the third instruction
ggplot(ChickWeight, aes( x = Time, y = weight, color = Diet) ) +
  geom_line(aes( group = Chick) )


# Use ggplot() for the last instruction
ggplot(ChickWeight, aes( x = Time, y = weight, color = Diet) ) +
  geom_line(aes( group = Chick), alpha = 0.3 ) + 
  geom_smooth( lwd = 2, se = FALSE)



# titanic is avaliable in your workspace

# Check out the structure of titanic
str(titanic)

# Use ggplot() for the first instruction
ggplot(titanic, aes( x = factor(Pclass), fill = factor(Sex))) +
  geom_bar( position = "dodge")

# Use ggplot() for the second instruction
ggplot(titanic, aes( x = factor(Pclass), fill = factor(Sex))) +
  geom_bar( position = "dodge") +
  facet_grid(". ~ Survived")

# Position jitter (use below)
posn.j <- position_jitter(0.5, 0)

# Use ggplot() for the last instruction
ggplot(titanic, aes( x = factor(Pclass),y = Age, col = factor(Sex))) +
  geom_jitter( size = 3, alpha = 0.5,  position = posn.j) +
  facet_grid(". ~ Survived")








