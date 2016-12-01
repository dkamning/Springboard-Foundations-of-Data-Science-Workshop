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

