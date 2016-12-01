#### CHAPTER 6:   #############

library(quantstrat)

##### Running your strategy #####
# use applyStrategy() to apply your strategy. Save this to out
out <- applyStrategy(strategy = strategy.st, portfolios = portfolio.st)

# update your portfolio (portfolio.st)
updatePortf(portfolio.st)
daterange <- time(getPortfolio(portfolio.st)$summary)[-1]

# update your account (account.st)
updateAcct(account.st, daterange)
updateEndEq(account.st)

# what is the date of the last trade?
"2015-12-23"


##### Profit factor ########
#The profit factor is how many dollars you make for each dollar you lose. A profit factor above 1 means your strategy is profitable.
# Get the tradeStats for your portfolio
tstats <- tradeStats(Portfolios = portfolio.st)

# Print the profit factor
tstats$Profit.Factor


#The percent positive statistic lets you know how many of your trades were winners. 

##### Using chart.Posn() ##############
# use chart.Posn to view your system's performance on SPY
#  This generates a crisp and informative visualization of the performance of your trading system over the course of the simulation.
chart.Posn(Portfolio = portfolio.st, Symbol = "SPY")


##### Adding an indicator to a chart.Posn() chart ##########
# compute the SMA50
sma50 <- SMA(x = Cl(SPY), n = 50)

# compute the SMA200
sma200 <- SMA(x = Cl(SPY), n = 200)

# compute the DVO_2_126 with an navg of 2 and a percentlookback of 126
dvo <- DVO(HLC = HLC(SPY), navg = 2, percentlookback = 126)

# recreate the chart.Posn of the strategy from the previous exercise
chart.Posn(Portfolio = portfolio.st, Symbol = "SPY")

# overlay the SMA50 on your plot as a blue line
add_TA(sma50, on = 1, col = "blue")

# overlay the SMA200 on your plot as a red line
add_TA(sma200, on = 1, col = "red")

# add the DVO_2_126 to the plot in a new window
add_TA(dvo)


#A Sharpe ratio is a metric that compares the average reward to the average risk taken. Generally, a Sharpe ratio above 1 is a marker of a strong strategy. 

##### Returns Sharpe ratio in quantstrat ####
# get instrument returns
instrets <- PortfReturns(portfolio.st)

# compute Sharpe ratio from returns
SharpeRatio.annualized(instrets, geometric = FALSE)


