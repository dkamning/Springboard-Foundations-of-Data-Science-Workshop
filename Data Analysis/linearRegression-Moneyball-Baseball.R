## Making it to the playoffs
moneyball = subset(baseball, Year < 2002)
str( moneyball)
moneyball$RD = moneyball$RS - moneyball$RA
str(moneyball)

WinsReg = lm(W ~ RD, data = moneyball)
summary(WinsReg)


## Predicting runs
RunsReg = lm(RS ~ OBP + SLG + BA, data = moneyball)
summary(RunsReg)


## Sabmetrics
