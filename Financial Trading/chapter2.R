##### CHAPTER 2: A BOILER PLATE FOR QUANTSTRAT ######################

#### Understanding initialization settings - I ##
# Load the quantstrat-package
library(quantstrat)

# Create initdate, from, and to charater strings
initdate <- "1999-01-01"
from <- "2003-01-01"
to <- "2015-12-31"

# Set the timezone to UTC
Sys.setenv(TZ = "UTC")

# Set the currency to USD 
currency("USD")


##### Understanding initialization settings - II ###
# Load the quantmod-package
library(quantmod)

# Retrieve SPY from yahoo
getSymbols("SPY", from = from, to = to, src = "yahoo", adjust = TRUE)

# Use the stock command to initialize SPY and set currency to USD
stock("SPY", currency = "USD")


##### Understanding initialization settings - III ####
# Define your trade size and initial equity
tradesize <- 100000
initeq <- 100000

# Define the names of your strategy, portfolio and account
strategy.st <- "firststrat"
portfolio.st <- "firststrat"
account.st <- "firststrat"

# Remove the existing strategy if it exists
rm.strat(strategy.st)


##### Understanding initialization settings - IV #####
# initialize the portfolio
initPortf(portfolio.st, symbols = "SPY", initDate = initdate, currency = "USD")

# initialize the account
initAcct(account.st, portfolios = portfolio.st, initDate = initdate, currency = "USD", initEq = initeq)

# initialize the orders
initOrders(portfolio.st, initDate = initdate)

# store the strategy
strategy(strategy.st, store = TRUE)

