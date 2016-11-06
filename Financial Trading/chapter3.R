#### CHAPTER 3: INDICATORS #############

#### The SMA and RSI functions #######
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


