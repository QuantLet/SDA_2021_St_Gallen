rm(list=ls())
jpegpath <- "/Plots/"

# First examine Bitcoin with Ethereum and Litecoin
btcusd <- readRDS("/Data/BTCUSD.RDS")
ethusd <- readRDS("/Data/ETHUSD.RDS")
ltcusd <- readRDS("/Data/LTCUSD.RDS")
xrpusd <- readRDS("/Data/XRPUSD.RDS")
bchusd <- readRDS("/Data/BCHUSD.RDS")

create_boxplot1 <- function(column,y){
  boxplot(btcusd[,column], ethusd[,column], ltcusd[,column], xlab="Currency Pair with USD",
          ylab=y, 
          names=c("BTC","ETH","LTC"),
          col=c("darkorange2", "darkslategrey", "deepskyblue3"))
}

jpeg(file=paste(jpegpath,"Boxplot_BTC-ETH-LTC.jpeg",sep=""))
par(mfrow=c(2,2))
create_boxplot1(6,"Volume")
create_boxplot1(5,"Volume weighted average")
create_boxplot1(1,"Open Price")
create_boxplot1(4,"Close Price")
dev.off()


create_boxplot2 <- function(column,y){
  boxplot(bchusd[,column], ethusd[,column], ltcusd[,column], xlab="Currency Pair with USD",
          ylab=y, 
          names=c("BCH","ETH","LTC"),
          col=c("yellow", "darkslategrey", "deepskyblue3"))
}

jpeg(file=paste(jpegpath,"Boxplot_BCH-ETH-LTC.jpeg",sep=""))
par(mfrow=c(2,2))
create_boxplot2(6,"Volume")
create_boxplot2(5,"Volume weighted average")
create_boxplot2(1,"Open Price")
create_boxplot2(4,"Close Price")
dev.off()


create_boxplot3 <- function(column,y){
  boxplot(xrpusd[,column], ethusd[,column], ltcusd[,column], xlab="Currency Pair with USD",
          ylab=y, 
          names=c("XRP","ETH","LTC"),
          col=c("darkgreen", "darkslategrey", "deepskyblue3"))
}

jpeg(file=paste(jpegpath,"Boxplot_XRP-ETH-LTC.jpeg",sep=""))
par(mfrow=c(2,2))
create_boxplot3(6,"Volume")
create_boxplot3(5,"Volume weighted average")
create_boxplot3(1,"Open Price")
create_boxplot3(4,"Close Price")
dev.off()

btceur <- readRDS("BTCEUR.RDS")
create_boxplot4 <- function(column,y){
  boxplot(btcusd[,column], btceur[,column], xlab="Currency Pair",
          ylab=y, 
          names=c("BTC-USD","BTC-EUR"),
          col=c("darkorange2", "darkorange1"))
}
jpeg(file=paste(jpegpath,"Boxplot_BTC.jpeg",sep=""))
par(mfrow=c(2,2))
create_boxplot4(6,"Volume")
create_boxplot4(5,"Volume weighted average")
create_boxplot4(1,"Open Price")
create_boxplot4(4,"Close Price")
dev.off()


# Bitcoin clearly deviates with respect to the analyzed characteristics from 
# the remaining cryptocurrencies. Also differences between Ripple and Ethereum
# and between Ripple and Litecoin. Bitcoin Cash, Litecoin and Ethereum appear
# to have less drastic differences.
