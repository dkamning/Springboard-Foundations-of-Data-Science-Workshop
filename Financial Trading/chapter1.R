#### CHAPTER 1: TRADING BASICS #########################
#setRepositories(addURLs =       c(Rforge = "http://R-Forge.R-project.org"))
#install.packages("quantstrat", repos="http://R-Forge.R-project.org", type="source")

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


