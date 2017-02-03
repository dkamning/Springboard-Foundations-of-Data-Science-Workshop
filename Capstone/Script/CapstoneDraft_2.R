#### CHAPTER 4: SIGNALS  #############

library(quantstrat)

##### Using sigComparison ################

# add a sigComparison which specifies that SMA50 must be greater than SMA200, call it longfilter
add.signal(strategy.st, name = "sigComparison", 
           
           # we are interested in the relationship between the SMA50 and the SMA200
           arguments = list(columns = c("SMA50", "SMA200"), 
                            
                            # particularly, we are interested when the SMA50 is greater than the SMA200
                            relationship = "gt"),
           
           # label this signal longfilter
           label = "longfilter")

##### Using sigCrossover ###########
# add a sigCrossover which specifies that the SMA50 is less than the SMA200 and label it filterexit
add.signal(strategy.st, name = "sigCrossover",
           
           # we're interested in the relationship between the SMA50 and the SMA200
           arguments = list(columns = c("SMA50", "SMA200"),
                            
                            # the relationship is that the SMA50 crosses under the SMA200
                            relationship = "lt"),
           
           # label it filterexit
           label = "filterexit")


##### Using sigThreshold - I ########
#sigThreshold() function takes the cross argument, which specifies whether it will function similarly to sigComparison (cross = FALSE) or sigCrossover (cross = TRUE), respectively.

# implement a sigThreshold which specifies that DVO_2_126 must be less than 20, label it longthreshold
add.signal(strategy.st, name = "sigThreshold", 
           
           # use the DVO_2_126 column
           arguments = list(column = "DVO_2_126", 
                            
                            # the threshold is 20
                            threshold =  20,
                            
                            # we want the oscillator to be under this value
                            relationship = "lt", 
                            
                            # we're interested in every instance that the oscillator is less than 20
                            cross = FALSE), 
           
           # label it longthreshold
           label = "longthreshold")


##### Using sigThreshold - II ###########
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



###### Using sigFormula ###########
# Create your dataset: test
test_init <- applyIndicators(strategy.st, mktdata = OHLC(mydata))
test <- applySignals(strategy = strategy.st, mktdata = test_init)
head(test)


##### Combining signals ############
# add a sigFormula signal to your code specifying that both longfilter and longthreshold must be TRUE, label it longentry
add.signal(strategy.st, name = "sigFormula",
           
           # specify that longfilter and longthreshold must be TRUE
           arguments = list(formula = "longfilter & longthreshold", 
                            
                            # specify that cross must be TRUE
                            cross = TRUE),
           
           # label it longentry
           label = "longentry")








#### CHAPTER 5: RULES  #############

library(quantstrat)

#Rules are a way for you to specify exactly how you will shape your transaction once you decide you wish to execute on a signal.

##### Using add.rule() to implement an exit rule #########
# fill in the rule's type as exit
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")

##### Specifying sigcol in add.rule() ######
# fill in the sigcol argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")

##### Specifying sigval in add.rule() #####
# fill in the sigval argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")

##### Specifying orderqty in add.rule() ######
# fill in the orderqty argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")


##### Specifying ordertype in add.rule() ####
#For the scope of this course you will stick to market orders (ordertype = "market"). A market order is an order that states that you will buy or sell the asset at the prevailing price, regardless of the conditions in the market.
# fill in the ordertype argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")


##### Specifying orderside in add.rule() ############
#A long trade is one that profits by buying an asset in the hopes that the asset's price will rise. A short trade is one that sells an asset before owning it, hoping to buy it back later at a lower price.
# fill in the orderside argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "filterexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")

##### Specifying replace in add.rule() #######
#In quantstrat, the replace argument specifies whether or not to ignore all other signals on the same date when the strategy acts upon one signal.
#In this case, you will be working with a rule that sells when the DVO has crossed a certain threshold. In particular, you will be working with the thresholdexit rule now.

# fill in the replace argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "thresholdexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")

##### Specifying prefer in add.rule() ####
# In quantstrat, orders have a "next-bar" mechanism.
# fill in the prefer argument in add.rule()
add.rule(strategy.st, name = "ruleSignal", 
         arguments = list(sigcol = "thresholdexit", sigval = TRUE, orderqty = "all", 
                          ordertype = "market", orderside = "long", 
                          replace = FALSE, prefer = "Open"), 
         type = "exit")


##### Using add.rule() to implement an entry rule ####
# create an entry rule of 1 share when all conditions line up to enter into a position
add.rule(strategy.st, name = "ruleSignal", 
         
         # use the longentry column as the sigcol
         arguments=list(sigcol = "longentry", 
                        
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

##### Implementing a rule with an order sizing function ########
#The constructs that allow quantstrat to vary the amount of shares bought or sold are called order sizing functions.
# add a rule that uses an osFUN to size an entry position
add.rule(strategy = strategy.st, name = "ruleSignal",
         arguments = list(sigcol = "longentry", sigval = TRUE, ordertype = "market",
                          orderside = "long", replace = FALSE, prefer = "Open",
                          
                          # use the osFUN called osMaxDollar
                          osFUN = osMaxDollar,
                          
                          # the tradeSize argument should be equal to tradesize (defined earlier)
                          tradeSize = tradesize,
                          
                          # the maxSize argument should be equal to tradesize as well
                          maxSize = tradesize),
         type = "enter")












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
# use chart.Posn to view your system's performance on mydata
#  This generates a crisp and informative visualization of the performance of your trading system over the course of the simulation.
chart.Posn(Portfolio = portfolio.st, Symbol = "mydata")


##### Adding an indicator to a chart.Posn() chart ##########
# compute the SMA50
sma50 <- SMA(x = Cl(mydata), n = 50)

# compute the SMA200
sma200 <- SMA(x = Cl(mydata), n = 200)

# compute the DVO_2_126 with an navg of 2 and a percentlookback of 126
dvo <- DVO(HLC = HLC(mydata), navg = 2, percentlookback = 126)

# recreate the chart.Posn of the strategy from the previous exercise
chart.Posn(Portfolio = portfolio.st, Symbol = "mydata")

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



