[<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/banner.png" width="888" alt="Visit QuantNet">](http://quantlet.de/)

## [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SDA_2022_Clustering_and_PCA_of_cryptocurrencies** [<img src="https://github.com/QuantLet/Styleguide-and-FAQ/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/)

```yaml

Name of Quantlet: 'SDA_2022_Clustering_and_PCA_of_cryptocurrencies'

Published in: 'SDA_2021_St_Gallen'

Description: 'Clustering and Principal Component Analysis of Cryptocurrency Daily Trading Data from 08/08/20 until 10/23/20 for Bitcoin, Ripple, LiteCoin, Ethereum, BitcoinCash'

Keywords: 'Bitcoin, BTC, Cryptocurrencies, Clustering, PCA'

Author: 'A Schmidt'

Submitted: '31 October 2022'

Input: 'Daily Trading Data from 08/08/20 until 10/23/20 for Bitcoin, Ripple, LiteCoin, Ethereum, BitcoinCash'

Output: 'Dendrogram and Principal Components depicting groups of cryptocurrencies'

```

### R Code
```r

rm(list=ls())

library(cluster)
library(factoextra)



# Section 1: Cluster Analysis 

data_scaled <- readRDS("/Data/Scaled_Data.RDS")

#Hierarchical clustering

create_cluster <- function(data,title){
  distance <- dist(data,"euclidian")
  cluster <- hclust(distance,"complete")
  jpeg(file=paste("/Plots/",title,".jpeg",sep=""))
  plot(cluster,main=title)
  dev.off()
}

create_cluster(data_scaled,"Dendrogram of cryptocurrency pairs in USD and EUR")


#Subsets considering only USD pairs and only EUR pairs 

data_scaled_USD <- data_scaled[1:5,]

create_cluster(data_scaled_USD,"Dendrogram of cryptocurrency pairs in USD")

data_scaled_EUR <- data_scaled[6:10,]
create_cluster(data_scaled_EUR,"Dendrogram of cryptocurrency pairs in EUR")




# Set number of clusters to 3, perform Cluster Mapping 

jpeg(file=paste("/Plots/","Cluster Mapping USD-Pairs",".jpeg",sep=""))
distance_USD <- dist(data_scaled_USD,"euclidian")
partitioning <- pam(distance_USD,3, diss = FALSE)
clusplot(partitioning, shade = FALSE,labels=2,col.clus="blue",col.p="red",span=FALSE,main="Cluster Mapping USD-Pairs",cex=0.8)
dev.off()


# Exclude BTC
data_scaled_USD_without <- data_scaled_USD[-1,]

jpeg(file=paste("/Plots/","Cluster Mapping USD-Pairs exlcuding BTC",".jpeg",sep=""))
distance_USD <- dist(data_scaled_USD_without,"euclidian")
partitioning <- pam(distance_USD,2, diss = FALSE)
clusplot(partitioning, shade = FALSE,labels=2,col.clus="blue",col.p="red",span=FALSE,main="Cluster Mapping USD-Pairs excluding BTC",cex=0.8)
dev.off()


# Section 2: PCA

rm(data_scaled,data_scaled_EUR,data_scaled_USD,data_scaled_USD_without)


#read R datasets

btcusd <- readRDS("/Data/BTCUSD.RDS")
btcusd$currency <- "BTCUSD"
ethusd <- readRDS("/Data/ETHUSD.RDS")
ethusd$currency <- "ETHUSD"
ltcusd <- readRDS("/Data/LTCUSD.RDS")
ltcusd$currency <- "LTCUSD"
xrpusd <- readRDS("/Data/XRPUSD.RDS")
xrpusd$currency <- "XRPUSD"
bchusd <- readRDS("/Data/BCHUSD.RDS")
bchusd$currency <- "BCHUSD"


data_USD <- rbind(btcusd, ethusd, ltcusd, xrpusd, bchusd)


# Normalized Pincipal Component analysis using whole dataset of USD pairs
fit <- princomp(data_USD[,-8], cor=TRUE)
summary(fit)
cor(data_USD[,-8],fit$score)

# First component: captures mainly prices
# second component: captures volume

jpeg(file=paste("/Plots/","PCA USD-Pairs",".jpeg",sep=""))
layout(matrix(1:4,2,2))
group <- factor(data_USD[,8])
plot(fit$scores[,1:2],col=group)
plot(fit$scores[,c(1,3)],col=group)
plot(fit$scores[,2:3],col=group)
plot(cumsum(fit$sdev^2/sum(fit$sdev^2)),ylab="Cumulative percentage variance")
dev.off()

# Again repeat, excluding Bitcoin 
data_USD <- subset(data_USD,currency!="BTCUSD")



fit <- princomp(data_USD[,-8], cor=TRUE)
summary(fit)
cor(data_USD[,-8],fit$score)

print(fit$loadings)
# First component: mainly prices
# second component: volume

jpeg(file=paste("/Plots/","PCA USD-Pairs excluding BTC",".jpeg",sep=""))
layout(matrix(1:4,2,2))
group <- factor(data_USD[,8])
plot(fit$scores[,1:2],col=group)
plot(fit$scores[,c(1,3)],col=group)
plot(fit$scores[,2:3],col=group)
plot(cumsum(fit$sdev^2/sum(fit$sdev^2)), ylab="Cumulative percentage variance")
dev.off()

#When excluding Bitcoin, the PCA performs better in differentiating between 
# the remaining different cryptocurrencies.

```

automatically created on 2022-11-06