#### CHAPTER 3: INDICATORS #############

library(quantstrat)

##### The SMA and RSI functions #######
# Create a 200-day moving average
spy_sma <- SMA(x = Cl(SPY), n = 200)

# Create an RSI with a 3 day lookback period
spy_rsi <- RSI(price = Cl(SPY), n = 3)


##### Visualize an indicator and guess its purpose - I ###
# Plot the closing prices of SPY
plot(Cl(SPY))

# Overlay a 200-day SMA
lines(SMA(Cl(SPY), n = 200), col = "red")

# Is this a trend or reversion indicator?
"trend"


##### Visualize an indicator and guess its purpose - II ###
# plot the closing price of SPY
plot(Cl(SPY))

# plot the RSI 2
plot(RSI(Cl(SPY), n = 2))

# trend or reversion?
"reversion"


##### Implementing an indicator - I ###
# Add a 200-day simple moving average indicator to your strategy
add.indicator(strategy = strategy.st, 
              
              # Add the SMA function
              name = "SMA", 
              
              # Create a lookback period
              arguments = list(x = quote(Cl(mktdata)), n = 200), 
              
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
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(mktdata))

# subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]




