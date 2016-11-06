library(ggplot2)
library(datasets)


#Have a look at the head() of the ChickWeight dataset, which has been loaded into your workspace. Looks like the data is pretty tidy!
#  First, make a plot which simply plots a line for each chick. Use ggplot() and map Time to x and weight to y within the aes() function. Add geom_line() at the end to draw the lines. To draw one line per chick, add group = Chick to the aes() of geom_line().
#Oops, that looks pretty chaotic and you can't really conclude anything from it. Let's try again. Copy the previous command but add a mapping within the aesthetics layer in ggplot(): map Diet onto color.
#There's some more information here, although it would be better to have some summary statistics as well. Let's think this over. Copy the previous command and add geom_smooth() with attributes lwd set to 2 and se set to False. Set alpha of geom_line() to 0.3.


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


