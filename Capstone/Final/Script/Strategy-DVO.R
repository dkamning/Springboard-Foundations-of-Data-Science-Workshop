
#### Load libraries ####
library(zoo)
library(xts)
library(TTR)
library(quantmod)

library(dplyr)
#library(data.table)

library(FinancialInstrument)
library(PerformanceAnalytics)
library(blotter)
library(Quandl)
library(foreach)
library(quantstrat)


#### Load scripts ####
#getwd()
#setwd('C:/Users/d_kamning/OneDrive for Business/Private/Springboard/Capstone')
source('functions_util.R')


#### LOAD DATA ####
### stockOne is AEP while stockTwo is CHK (Chesapeake Energy Corp.) ###
stockOne <- Quandl("WIKI/AEP", start_date = "2000-01-01", end_date = "2017-01-31", type = "xts")
head(stockOne)
stockOne <- stockOne[, c(1, 2, 3, 4, 5, 6)]


stockTwo <- Quandl("WIKI/CHK", start_date = "2000-01-01", end_date = "2017-01-31", type = "xts")
head(stockTwo)
stockTwo <- stockTwo[, c(1, 2, 3, 4, 5, 6)]


#### INITIALIZE STRATEGY ####
### Create initdate, from, and to charater strings
initdate <- "2000-01-01"
from <- "2003-01-01"
to <- "2016-12-31"

### Set the timezone to UTC
#OlsonNames()
Sys.setenv(TZ = "EST")

### Set the currency to USD 
currency("USD")

### Use the stock command to initialize and set currency to USD
stock(c("stockOne", "stockTwo"), currency = "USD")


### Define your trade size and initial equity
tradesize <- 100000
initeq <- 100000

### Define the names of your strategy, portfolio and account
strategy.st <- "DVO strategy"
portfolio.st <- "DVO strategy"
account.st <- "DVO strategy"

### Remove the existing strategy if it exists
rm.strat(strategy.st)


### initialize the portfolio
initPortf(portfolio.st, symbols = c("stockOne", "stockTwo"), initDate = initdate, currency = "USD")

### initialize the account
initAcct(account.st, portfolios = portfolio.st, initDate = initdate, currency = "USD", initEq = initeq)

### initialize the orders
initOrders(portfolio.st, initDate = initdate)

### store the strategy
strategy(strategy.st, store = TRUE)



#### ADD SMA INDICATORS (TREND) ####
### 1. Add a 200-day simple moving average indicator to your strategy
add.indicator(strategy = strategy.st,
# Add the SMA function
                  name = "SMA",
# Create a lookback period
                  arguments = list(x = quote(Cl(mktdata)), n = 200),
# Label your indicator SMA200
                  label = "SMA200")


### 2. Add a 50-day simple moving average indicator to your strategy
add.indicator(strategy = strategy.st,
# Add the SMA function
                  name = "SMA",
# Create a lookback period
                  arguments = list(x = quote(Cl(mktdata)), n = 50),
# Label your indicator SMA50
                  label = "SMA50")



##### ADD CUSTOM RSI INDICATOR (REVERSION) ####
### Add the RSI_avg function to your strategy using an n1 of 3 and an n2 of 4, and label it "RSI_3_4"
add.indicator(strategy.st, name = "RSI_avg", arguments = list(price = quote(Cl(mktdata)), n1 = 3, n2 = 4), label = "RSI_3_4")



#### ADD OSCILLATOR DVO (David Varadi Oscillator, originated by David Varadi) ####
### Add the DVO indicator to your strategy
add.indicator(strategy = strategy.st, name = "DVO",
              arguments = list(HLC = quote(HLC(mktdata)), navg = 2, percentlookback = 126),
              label = "DVO_2_126")

### Use applyIndicators to test out your indicators
#test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(marketdata))
test <- applyIndicators(strategy = strategy.st, mktdata = OHLC(stockOne))
head(test)

test2 <- applyIndicators(strategy = strategy.st, mktdata = OHLC(stockTwo))
head(test2)

### Subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

test_subset2 <- test2["2013-09-01/2013-09-05"]
test_subset2



#### ADD SIGNALS ####
### 1. Using sigComparison ################
# add a sigComparison which specifies that SMA50 must be greater than SMA200, call it longfilter
add.signal(strategy.st, name = "sigComparison",
# we are interested in the relationship between the SMA50 and the SMA200
               arguments = list(columns = c("SMA50", "SMA200"),
# particularly, we are interested when the SMA50 is greater than the SMA200
                                relationship = "gt"),
# label this signal longfilter
               label = "longfilter")

### 2. Using sigCrossover ###########
# add a sigCrossover which specifies that the SMA50 is less than the SMA200 and label it filterexit
add.signal(strategy.st, name = "sigCrossover",
# we're interested in the relationship between the SMA50 and the SMA200
               arguments = list(columns = c("SMA50", "SMA200"),
# the relationship is that the SMA50 crosses under the SMA200
                                relationship = "lt"),
# label it filterexit
               label = "filterexit")


### 3.a Using sigThreshold - I ########
# SigThreshold() function takes the cross argument, which specifies whether it will function similarly to sigComparison (cross = FALSE) or sigCrossover (cross = TRUE), respectively.
# Implement a sigThreshold which specifies that DVO_2_126 must be less than 20, label it longthreshold
add.signal(strategy.st, name = "sigThreshold",
# use the DVO_2_126 column
               arguments = list(column = "DVO_2_126",
# the threshold is 20
                                threshold = 20,
# we want the oscillator to be under this value
                                relationship = "lt",
# we're interested in every instance that the oscillator is less than 20
                                cross = FALSE),
# label it longthreshold
               label = "longthreshold")


### 3.b Using sigThreshold - II ###########
# add a sigThreshold signal to your strategy that specifies that DVO_2_126 must cross above 80 and label it thresholdexit
add.signal(strategy.st, name = "sigThreshold",
# reference the column of DVO_2_126
               arguments = list(column = "DVO_2_126",
# set a threshold of 80
                                threshold = 80,
# the oscillator must be greater than 80
                                relationship = "gt",
# we are interested only in the cross
                                cross = TRUE),
# label it thresholdexit
               label = "thresholdexit")


# Create your dataset: test
test_init <- applyIndicators(strategy.st, mktdata = OHLC(stockOne))
test <- applySignals(strategy = strategy.st, mktdata = test_init)
head(test)

test_init2 <- applyIndicators(strategy.st, mktdata = OHLC(stockTwo))
test2 <- applySignals(strategy = strategy.st, mktdata = test_init2)
head(test2)

### Subset your data between Sep. 1 and Sep. 5 of 2013
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

test_subset2 <- test2["2013-09-01/2013-09-05"]
test_subset2


### 4. Using sigFormula, Combining signals ############
# add a sigFormula signal to your code specifying that both longfilter and longthreshold must be TRUE, label it longentry
add.signal(strategy.st, name = "sigFormula",
# specify that longfilter and longthreshold must be TRUE
               arguments = list(formula = "longfilter & longthreshold",
# specify that cross must be TRUE
                                cross = TRUE),
# label it longentry
               label = "longentry")

# Test
test_init <- applyIndicators(strategy.st, mktdata = OHLC(stockOne))
test <- applySignals(strategy = strategy.st, mktdata = test_init)
head(test)
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

test_init2 <- applyIndicators(strategy.st, mktdata = OHLC(stockTwo))
test2 <- applySignals(strategy = strategy.st, mktdata = test_init2)
head(test2)
test_subset2 <- test2["2013-09-01/2013-09-05"]
test_subset2


#### ADD RULES ####
### Using add.rule() to implement an exit rule #########
add.rule(strategy.st, name = "ruleSignal",
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all",
                          ordertype = "market", orderside = "long",
                          replace = FALSE, prefer = "Open"),
         type = "exit")

#In quantstrat, the replace argument specifies whether or not to ignore all other signals on the same date when the strategy acts upon one signal.
### In this case, you will be working with a rule that sells when the DVO has crossed a certain threshold. In particular, you will be working with the thresholdexit rule now.
add.rule(strategy.st, name = "ruleSignal",
         arguments = list(sigcol = "thresholdexit", sigval = TRUE, orderqty = "all",
                          ordertype = "market", orderside = "long",
                          replace = FALSE, prefer = "Open"),
         type = "exit")


### Using add.rule() to implement an entry rule #########
# create an entry rule of 1 share when all conditions line up to enter into a position
add.rule(strategy.st, name = "ruleSignal",
# use the longentry column as the sigcol
             arguments = list(sigcol = "longentry",
# set sigval to TRUE
                            sigval = TRUE,
# set orderqty to 1, all can only be used for exit rules
                            orderqty = 1,
# use a market type of order
                            ordertype = "market",
# take the long orderside
                            orderside = "long",
# do not replace other signals
                            replace = FALSE,
# buy at the next day's opening price
                            prefer = "Open"),
# this is an enter type rule, not an exit
             type = "enter")


### Implementing a rule with an order sizing function ########
### The constructs that allow quantstrat to vary the amount of shares bought or sold are called order sizing functions.
### add a rule that uses an osFUN to size an entry position
#add.rule(strategy = strategy.st, name = "ruleSignal",
#arguments = list(sigcol = "longentry", sigval = TRUE, ordertype = "market",
#orderside = "long", replace = FALSE, prefer = "Open",
## use the osFUN called osMaxDollar
#osFUN = osMaxDollar,
## the tradeSize argument should be equal to tradesize (defined earlier)
#tradeSize = tradesize,
## the maxSize argument should be equal to tradesize as well
#maxSize = tradesize),
#type = "enter")


# Test
test_init <- applyIndicators(strategy.st, mktdata = OHLC(stockOne))
test <- applySignals(strategy = strategy.st, mktdata = test_init)
head(test)
test_subset <- test["2013-09-01/2013-09-05"]
test_subset

test_init2 <- applyIndicators(strategy.st, mktdata = OHLC(stockTwo))
test2 <- applySignals(strategy = strategy.st, mktdata = test_init2)
head(test2)
test_subset2 <- test2["2013-09-01/2013-09-05"]
test_subset2

#View(test)
#View(test2)



#### RUNNING YOUR STRATEGY ####
### Use applyStrategy() to apply your strategy. Save this to out
out <- applyStrategy(strategy = strategy.st, portfolios = portfolio.st)

### Update your portfolio (portfolio.st)
updatePortf(portfolio.st)
daterange <- time(getPortfolio(portfolio.st)$summary)[-1]

### Update your account (account.st)
updateAcct(account.st, daterange)
updateEndEq(account.st)

### what is the date of the last trade?
"2015-12-23"


### Profit factor ########
#The profit factor is how many dollars you make for each dollar you lose. A profit factor above 1 means your strategy is profitable.
# Get the tradeStats for your portfolio
tstats <- tradeStats(Portfolios = portfolio.st)

# Print the profit factor
#tstats$Profit.Factor
tstats[, c("Symbol", "Profit.Factor")]


#### USING CHART.POSN() ####
### use chart.Posn to view your system's performance on stocks
#  This generates a crisp and informative visualization of the performance of your trading system over the course of the simulation.
# Chart trades against market data, position through time, and cumulative P\&L
# Produces a three-panel chart of time series charts that contains prices and transactions in the top panel, the resulting position in the second, and a cumulative profit-loss line chart in the third. 
# The percent positive statistic lets you know how many of your trades were winners. 

chart.Posn(Portfolio = portfolio.st, Symbol = "stockOne")
### Adding indicators to a chart.Posn() chart ##########
# compute the SMA50
sma50 <- SMA(x = Cl(stockOne), n = 50)
# compute the SMA200
sma200 <- SMA(x = Cl(stockOne), n = 200)
# compute the DVO_2_126 with an navg of 2 and a percentlookback of 126
dvo <- DVO(HLC = HLC(stockOne), navg = 2, percentlookback = 126)
# recreate the chart.Posn of the strategy 
chart.Posn(Portfolio = portfolio.st, Symbol = "stockOne")
# overlay the SMA50 on your plot as a blue line
add_TA(sma50, on = 1, col = "blue")
# overlay the SMA200 on your plot as a red line
add_TA(sma200, on = 1, col = "red")
# add the DVO_2_126 to the plot in a new window
add_TA(dvo)


chart.Posn(Portfolio = portfolio.st, Symbol = "stockTwo")
### Adding indicators to a chart.Posn() chart ##########
# compute the SMA50
sma50 <- SMA(x = Cl(stockOne), n = 50)
# compute the SMA200
sma200 <- SMA(x = Cl(stockOne), n = 200)
# compute the DVO_2_126 with an navg of 2 and a percentlookback of 126
dvo <- DVO(HLC = HLC(stockOne), navg = 2, percentlookback = 126)
# recreate the chart.Posn of the strategy 
chart.Posn(Portfolio = portfolio.st, Symbol = "stockTwo")
# overlay the SMA50 on your plot as a blue line
add_TA(sma50, on = 1, col = "blue")
# overlay the SMA200 on your plot as a red line
add_TA(sma200, on = 1, col = "red")
# add the DVO_2_126 to the plot in a new window
add_TA(dvo)


#### ANALYZE OUTPUT ####
# Order Book
getOrderBook(portfolio.st)
# Update Portfolio
updatePortf(portfolio.st, Symbol = c("stockOne", "stockTwo"))

# Strategy output with trdeStats
tradeStats(portfolio.st, Symbol = c("stockOne", "stockTwo"))
View(t(tradeStats(portfolio.st)))

#### COMPUTE SHARPE RATIO ####
### A Sharpe ratio is a metric that compares the average reward to the average risk taken. Generally, a Sharpe ratio above 1 is a marker of a strong strategy. 
# Get instrument returns
instrets <- PortfReturns(portfolio.st)

# Compute Sharpe ratio from returns
SharpeRatio.annualized(instrets, geometric = FALSE)


