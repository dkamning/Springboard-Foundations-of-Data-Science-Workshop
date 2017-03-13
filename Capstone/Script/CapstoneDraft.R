
install.packages("FinancialInstrument")
install.packages("PerformanceAnalytics")
install.packages("foreach")
install.packages("xts")

install.packages("C:/Users/kamni/Documents/R/blotter_0.9.1741.zip", repos = NULL, type="source")
install.packages("C:/Users/kamni/Documents/R/quantstrat_0.9.1739.zip", repos = NULL, type="source")

library(zoo)
library( xts)
library(TTR)
library( quantmod)


### Load libraries
library(dplyr)
library(data.table)

library(FinancialInstrument)
library(PerformanceAnalytics)
library(blotter)
library(Quandl)
library(foreach)
library(quantstrat)


### Load data from Quandl

#mydata = Quandl("WIKI/AEP", start_date="2000-01-01", end_date="2016-11-30", type="raw")
#head(mydata)
#mydata <- mydata[, c( 1,2,3,4,5,6)]
#head(mydata)

#mydata <- as.xts( mydata)

mydata <- Quandl("WIKI/AEP", start_date="2000-01-01", end_date="2017-01-31", type="xts")
head(mydata)
mydata <- mydata[, c( 1,2,3,4,5,6)]


#getSymbols("", from = "2000-01-01", to = "2016-06-30", src = mydata , adjust = TRUE)


### Plot the closing prices
#plot(  mydata$Date, mydata$Close, type = 'l')
plot( Cl(mydata ), type = 'l')

#i <- 1:10
#plot(mydata$Date[i], mydata$Close[i],type='l')
#plot(mydata$Date[i], mydata$Close[i])
#lines(mydata$Date[i], SMA(mydata$Close, n = 200), col = "red")


### Add a 200-day moving average using the lines command
#lines( mydata$Date, SMA(  mydata$Close, n = 200), col = "red")
lines( SMA(  Cl(mydata ), n = 200), col = "red")
lines( SMA(  Cl(mydata ), n = 300), col = "purple")
lines( SMA(  Cl(mydata ), n = 50), col = "cyan")

############## chap 2: Initialization  ############
### Create initdate, from, and to charater strings
initdate <- "2000-01-01"
from <- "2003-01-01"
to <- "2016-12-31"

### Set the timezone to UTC
Sys.setenv(TZ = "ET")

### Set the currency to USD 
currency("USD")

### Use the stock command to initialize and set currency to USD
stock("mydata", currency = "USD")


### Define your trade size and initial equity
tradesize <- 100000
initeq <- 100000

### Define the names of your strategy, portfolio and account
strategy.st <- "firststrat"
portfolio.st <- "firststrat"
account.st <- "firststrat"

### Remove the existing strategy if it exists
rm.strat(strategy.st)


### initialize the portfolio
initPortf(portfolio.st, symbols = "mydata", initDate = initdate, currency = "USD")

### initialize the account
initAcct(account.st, portfolios = portfolio.st, initDate = initdate, currency = "USD", initEq = initeq)

### initialize the orders
initOrders(portfolio.st, initDate = initdate)

### store the strategy
strategy(strategy.st, store = TRUE)








#### CHAPTER 3: INDICATORS #############


##### The SMA and RSI functions #######
### Create a 200-day moving average
spy_sma <- SMA( x = Cl(mydata), n = 200)

### Create an RSI with a 3 day lookback period
spy_rsi <- RSI( price = Cl(mydata), n = 3)


##### Visualize an indicator and guess its purpose - I ###
# Plot the closing prices 
plot(Cl(mydata), type = "l")

# Overlay a 200-day SMA
lines(SMA( Cl(mydata), n = 200), col = "red", type = "l")

# Is this a trend or reversion indicator?
"trend"


##### Visualize an indicator and guess its purpose - II ###
# plot the closing price of SPY
plot( Cl(mydata), type = "l")

# plot the RSI 2
plot( RSI( Cl(mydata), n = 2), type = "l")

# trend or reversion?
"reversion"


##### Implementing an indicator - I ###
# Add a 200-day simple moving average indicator to your strategy
#mktdata <- OHLC( mydata)
#head( mktdata)

add.indicator(strategy = strategy.st, 
              
              # Add the SMA function
              name = "SMA", 
              
              # Create a lookback period
              arguments = list(x = quote( Cl(mktdata) ), n = 200), 
              
              # Label your indicator SMA200
              label = "SMA200")



##### Implementing an indicator - II ##
# Add a 50-day simple moving average indicator to your strategy
add.indicator(strategy = strategy.st, 
              
              # Add the SMA function
              name = "SMA", 
              
              # Create a lookback period
              arguments = list(x = quote(Cl(mktdata)), n = 50), 
              
              # Label your indicator SMA50
              label = "SMA50")



##### Implementing an indicator - III ##
# add an RSI 3 indicator to your strategy: 100 - 100/(1 + RS)
add.indicator(strategy = strategy.st, 
              
              # add an RSI function to your strategy
              name = "RSI", 
              
              # use a lookback period of 3 days
              arguments = list(price = quote(Cl(mktdata)), n = 3), 
              
              # label it RSI_3
              label = "RSI_3")


##### Code your own indicator - I ################
# Write the RSI_avg function
RSI_avg <- function(price, n1, n2) {
  
  # RSI 1 takes an input of the price and n1
  rsi_1 <- RSI(price = price, n = n1)
  
  # RSI 2 takes an input of the price and n2
  rsi_2 <- RSI(price = price, n = n2)
  
  # RSI_avg is the average of rsi_1 and rsi_2
  RSI_avg <- (rsi_1 + rsi_2)/2
  
  # Your output of RSI_avg needs a column name of "RSI_avg"
  colnames(RSI_avg) <- "RSI_avg"
  return(RSI_avg)
}

# Add the RSI_avg function to your strategy using an n1 of 3 and an n2 of 4, and label it "RSI_3_4"
add.indicator(strategy.st, name = "RSI_avg", arguments = list(price = quote(Cl(mktdata)), n1 = 3, n2 = 4  ), label = "RSI_3_4")



###### David Varadi Oscillator (DVO for short), originated by David Varadi ###
# Declare the DVO function. The first argument is the high, low, and close of market data. The three arguments for your function will be HLC, navg (default to 2), and percentlookback (default to 126)
DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
#help(applyIndicators)
#help("OHLCV")
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mydata))
test
# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset


DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))
head(test)

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))
head(test)

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset


DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))
head(test)

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))
head(test)

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

DVO <- function(HLC, navg = 2, percentlookback = 126) {
  
  # Compute the ratio between closing prices to the average of high and low
  ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC))/2 )
  
  # Smooth out the ratio outputs using a moving average
  avgratio <- SMA(ratio, n = navg)
  
  # Convert ratio into a 0-100 value using runPercentRank function
  out <- runPercentRank( avgratio, n = percentlookback, exact.multiplier = 1) * 100
  colnames(out) <- "DVO"
  return(out)
}


##### Apply your own indicator ################
#In order to subset time-series data, use the command ts["YYYY-MM-DD/YYYY-MM-DD"]. For example, ts["2003-01-01/2003-12-31"] will subset data for all of 2003.
# add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO", 
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

# use applyIndicators to test out your indicators
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))
head(test)

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

