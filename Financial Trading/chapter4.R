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
test_init <- applyIndicators(strategy.st, mktdata = OHLC(SPY))
test <- applySignals(strategy = strategy.st, mktdata = test_init)


##### Combining signals ############
# add a sigFormula signal to your code specifying that both longfilter and longthreshold must be TRUE, label it longentry
add.signal(strategy.st, name = "sigFormula",
           
           # specify that longfilter and longthreshold must be TRUE
           arguments = list(formula = "longfilter & longthreshold", 
                            
                            # specify that cross must be TRUE
                            cross = TRUE),
           
           # label it longentry
           label = "longentry")

