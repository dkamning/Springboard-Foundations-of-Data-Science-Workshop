#### INSTALL LIBRARIES ####
install.packages("rmarkdown") #install.packages("rmarkdown", lib="C:/Users/d_kamning/Documents/R/win-library/3.3")

#### Load libraries ####
library(rmarkdown)
library(zoo)
library(xts)
library(TTR)
#library(quantmod)

library(dplyr)
#library(data.table)

library(FinancialInstrument)
library(PerformanceAnalytics)
library(blotter)
library(Quandl)
#library(foreach)
#library(quantstrat)


#### LOAD DATA ####
### stockOne is AEP while stockTwo is CHK (Chesapeake Energy Corp.) ###
stockOne <- Quandl("WIKI/AEP", start_date = "2000-01-01", end_date = "2017-01-31", type = "xts")
head(stockOne)
stockOne <- stockOne[, c(1, 2, 3, 4, 5, 6)]


stockTwo <- Quandl("WIKI/CHK", start_date = "2000-01-01", end_date = "2017-01-31", type = "xts")
head(stockTwo)
stockTwo <- stockTwo[, c(1, 2, 3, 4, 5, 6)]



#### VISUALIZE DATA ####
plot(Cl(stockOne), type = 'l', xlab = 'Date', ylab = 'Closing price', main = 'AEP closing price trend with SMA')
lines(SMA(Cl(stockOne), n = 200), col = "red")
lines(SMA(Cl(stockOne), n = 300), col = "purple")
lines(SMA(Cl(stockOne), n = 50), col = "cyan")
legend('topleft', c("SMA200", "SMA300", "SMA50", "Closing price"),
    lty = c(1, 1), lwd = c(2.5, 2.5), col = c('red', 'purple', 'cyan', "black"), cex = .50)

plot(Cl(stockTwo), type = 'l', xlab = 'Date', ylab = 'Closing price', main = 'CHK closing price trend with SMA')
lines(SMA(Cl(stockTwo), n = 200), col = "red")
lines(SMA(Cl(stockTwo), n = 300), col = "purple")
lines(SMA(Cl(stockTwo), n = 50), col = "cyan")
legend('topleft', c("SMA200", "SMA300", "SMA50", "Closing price"),
    lty = c(1, 1), lwd = c(2.5, 2.5), col = c('red', 'purple', 'cyan', "black"), cex = .50)


plot(RSI(Cl(stockOne), n = 3), type = "l", xlab = 'Date', ylab = 'Closing price', main = 'AEP closing price RSI with 3-days lookback')
plot(RSI(Cl(stockTwo), n = 3), type = "l", xlab = 'Date', ylab = 'Closing price', main = 'CHK closing price RSI with 3-days lookback')
