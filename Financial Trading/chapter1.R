#### CHAPTER 1: TRADING BASICS #########################

#######################################################################
#help(quantstrat)
#Author(s):
  
#  Peter Carl, Brian G. Peterson, Joshua Ulrich, Garrett See, Yu Chen

#Maintainer: Brian G. Peterson <brian@braverock.com>
###############################################################################
  
  
#setRepositories(addURLs =       c(Rforge = "http://R-Forge.R-project.org"))

install.packages("FinancialInstrument")
install.packages("PerformanceAnalytics")
install.packages("foreach")
install.packages("xts")
#install.packages("quantstrat", repos="http://R-Forge.R-project.org")
#install.packages("quantstrat", repos="http://R-Forge.R-project.org", type="source")
install.packages("C:/Users/kamni/Documents/R/blotter_0.9.1741.zip", repos = NULL, type="source")
install.packages("C:/Users/kamni/Documents/R/quantstrat_0.9.1739.zip", repos = NULL, type="source")

library(quantstrat)
library(TTR)

##### PLOTTING FINANCIAL DATA #############
# Get SPY from Yahoo Finance ("yahoo")
getSymbols("SPY", from = "2000-01-01", to = "2016-06-30", src = "yahoo" , adjust = TRUE)

# Plot the closing price of SPY
plot(Cl(SPY))


###### Adding a moving average to financial data
# Plot the closing prices of SPY
plot(Cl(SPY))

# Add a 200-day moving average using the lines command
lines( SMA(Cl(SPY), n = 200), col = "red")


