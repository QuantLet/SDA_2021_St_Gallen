rm(list=ls())
datapath <- "/Data/"

load_data <- function(pair){
  x <- read.csv(paste(wd,datapath,pair,sep=""))
  x <- x[,c(-1,-2)]                             #drop variables X and time
  return(x)
}

btcusd <- load_data("XBTUSD.csv")
ethusd <- load_data("ETHUSD.csv")
ltcusd <- load_data("LTCUSD.csv")
xrpusd <- load_data("XRPUSD.csv")
bchusd <- load_data("BCHUSD.csv")

btceur <- load_data("XBTEUR.csv")
etheur <- load_data("ETHEUR.csv")
ltceur <- load_data("LTCEUR.csv")
xrpeur <- load_data("XRPEUR.csv")
bcheur <- load_data("BCHEUR.csv")

# Save these R dataframes for boxplots created later.
saveRDS(btcusd,"Data/BTCUSD.RDS")
saveRDS(ethusd, "Data/ETHUSD.RDS")
saveRDS(ltcusd, "Data/LTCUSD.RDS")
saveRDS(xrpusd, "Data/XRPUSD.RDS")
saveRDS(bchusd, "Data/BCHUSD.RDS")

saveRDS(btceur,"Data/BTCEUR.RDS")
saveRDS(etheur, "Data/ETHEUR.RDS")
saveRDS(ltceur, "Data/LTCEUR.RDS")
saveRDS(xrpeur, "Data/XRPEUR.RDS")
saveRDS(bcheur, "Data/BCHEUR.RDS")

# Determine average values for each currency and for later analyses

construct_data <- function(data,pairname){
  x <- as.data.frame(matrix(NA,nrow=1,ncol=ncol(data)))
  x[] <- lapply(data,mean)
  colnames(x) <- colnames(data)
  x$currency <- rep(pairname,1)
  return(x)
}

btcusd <- construct_data(btcusd,"BTCUSD")
ethusd <- construct_data(ethusd,"ETHUSD")
ltcusd <- construct_data(ltcusd,"LTCUSD")
xrpusd <- construct_data(xrpusd, "XRPUSD")
bchusd <- construct_data(bchusd, "BCHUSD")



btceur <- construct_data(btceur,"BTCEUR")
etheur <- construct_data(etheur,"ETHEUR")
ltceur <- construct_data(ltceur,"LTCEUR")
xrpeur <- construct_data(xrpeur, "XRPEUR")
bcheur <- construct_data(bcheur, "BCHEUR")

data <- rbind(btcusd, ethusd,ltcusd,xrpusd,bchusd,btceur,etheur,ltceur,xrpeur, bcheur)
data <- data %>% column_to_rownames(.,var="currency")
data_scaled <- scale(data)
saveRDS(data_scaled,"Data/Scaled_Data.RDS")
