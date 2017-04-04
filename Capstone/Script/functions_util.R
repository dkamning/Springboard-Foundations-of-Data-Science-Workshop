#### Load libraries ####
library( quantstrat)

##### ADD CUSTOM RSI INDICATOR (REVERSION) ####
### Write the RSI_avg function
RSI_avg <- function(price, n1, n2) {

    # RSI 1 takes an input of the price and n1
    rsi_1 <- RSI(price = price, n = n1)

    # RSI 2 takes an input of the price and n2
    rsi_2 <- RSI(price = price, n = n2)

    # RSI_avg is the average of rsi_1 and rsi_2
    RSI_avg <- (rsi_1 + rsi_2) / 2

    # Your output of RSI_avg needs a column name of "RSI_avg"
    colnames(RSI_avg) <- "RSI_avg"
    return(RSI_avg)
}

#### ADD OSCILLATOR DVO (David Varadi Oscillator, originated by David Varadi) ####
#' Title
#'
#' @param HLC
#' @param navg
#' @param percentlookback
#'
#' @return
#' @export
#'
#' @examples
DVO <- function(HLC, navg = 2, percentlookback = 126) {

    # Compute the ratio between closing prices to the average of high and low
    ratio <- Cl(HLC) / ((Hi(HLC) + Lo(HLC)) / 2)

    # Smooth out the ratio outputs using a moving average
    avgratio <- SMA(ratio, n = navg)

    # Convert ratio into a 0-100 value using runPercentRank function
    out <- runPercentRank(avgratio, n = percentlookback, exact.multiplier = 1) * 100
    colnames(out) <- "DVO"
    return(out)
}





osMaxDollar <-
    function(data, timestamp, orderqty, ordertype, orderside,
                                    portfolio, symbol, prefer = "Open", tradeSize,
                                    maxSize, integerShares = FALSE,
                                    ...) {
        pos <- getPosQty(portfolio, symbol, timestamp)
        if (prefer == "Close") {
            price <- as.numeric(Cl(mktdata[timestamp,]))
        } else {
            price <- as.numeric(Op(mktdata[timestamp,]))
        }
        posVal <- pos * price
        if (orderside == "short") {
            dollarsToTransact <- max(tradeSize, posVal - maxSize)
        } else {
            dollarsToTransact <- min(tradeSize, maxSize - posVal)
        }
        qty <- dollarsToTransact / price
        if (integerShares) {
            if (qty > 0) {
                qty <- floor(qty)
            }
            if (qty < 0) {
                qty <- ceiling(qty)
            }
        }
        return(qty)
    }


