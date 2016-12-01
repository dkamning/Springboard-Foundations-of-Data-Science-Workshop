### Load libraries
library(dplyr)
library(data.table)

library(Quandl)
library(quantstrat)


### Load data to data frame

#titanic_dataset <- read.csv(file="./Data Wrangling/Exo2/titanic_original.csv"
 #                           , head = TRUE, sep=",")
#str(titanic_dataset)


mydata = Quandl("WIKI/AEP", type="xts", start_date="2000-01-01", end_date="2016-11-30")
head(mydata)


#getSymbols("", from = "2000-01-01", to = "2016-06-30", src = mydata , adjust = TRUE)


### Plot the closing prices
plot(Cl( mydata))

### Add a 200-day moving average using the lines command
lines( SMA( Cl( mydata ), n = 200), col = "red")
