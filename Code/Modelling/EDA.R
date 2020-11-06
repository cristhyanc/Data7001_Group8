setwd("C:\\Users\\Matt\\Documents\\University\\Masters\\DATA7001\\Team Project\\Combine")
data <- read.csv("combined.csv")

# Sigmoid function for logit regression
sigmoid <- function(x) {
  return (1/(1+exp(-x)))
}

# Setup for dataframes
data['logCost'] <- log(data$TotalEstimatedCost)
data['padjLogCost'] <- log(data$TotalEstimatedCost/data$Tot_P)
data['isALP'] <- as.integer(unclass(as.factor(data$Party))==1)
data['sigmoidMargin'] <- sigmoid(data$MarginPower)

safety <- as.data.frame(model.matrix(~Safety, data = data)[,2:4])
safety['SafetyFairly'] <- 1 - rowSums(safety)
safety['logCost'] = data['logCost']


# Produce correlation values with logCost as a way to search
library(Hmisc)

numericData = data[,unlist(lapply(data, is.numeric))]
numericData <- numericData[complete.cases(numericData), ]

corrMatrix = cor(numericData)
logCostCorrVals = as.data.frame(corrMatrix)['logCost']
logCostCorrPvals = as.data.frame(rcorr(as.matrix(numericData), type="pearson")$P)['logCost']
logCostCorr = cbind(logCostCorrVals,logCostCorrPvals)


library(corrplot)
corrData = data.frame(data$logCost,data$Margin, data$sigmoidMargin,
                      data$MarginPower, data$isALP,
                      data$Tot_Population, data$Working_Age,
                      log(data$Median_tot_fam_inc_weekly),
                      log(data$Median_rent_weekly),
                      data$Australian_citizen_P/data$Tot_Population,
                      data$Indig_psns_Torres_Strait_Is_P/data$Tot_Population,
                      data$Unemploy, data$Ave_Motor_Vehicle_per_Dwelling,
                      data$One_method_Car_as_driver_P/data$Tot_Population)
names(corrData) <- c("Log Spending","Seat Margin","Sigmoid Margin","ALP Margin","Is ALP",
                     "Population", "Proportion Working Age", 
                     "Log Household Income","Log Weekly Rent", 
                     "Proportion Citizen", "Proportion Indig/TSI",
                     "Proportion Umemploy", "Vehicle per Dwelling", "Work by Car")
M <- cor(corrData, use = "complete.obs")

# Correlations plot
p_vals_mat <- cor.mtest(corrData, use = "complete.obs")$p
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(M,  method="color", col = col(200), type="upper",
         p.mat = p_vals_mat, insig = "label_sig", sig.level = 0.05, pch.col = "white",
         tl.col = "black", tl.srt = 90, diag = FALSE)


###### Plots and models #####
# Linear models
plot(data$MarginPower,data$logCost, col=rgb(0,0,1,0.5), main = "Electorate Spending vs Margin for Labour", xlab="Margin for Labour (%)", ylab="Log State Gov Spending")
lmfit<-with(data,lm(logCost~MarginPower))
summary(lmfit)
predx = seq(min(data$MarginPower),max(data$MarginPower))
predprobs<-predict(lmfit,data.frame(MarginPower=predx),interval="prediction",level = 0.95,type="response")
lines(predx,predprobs[,1],col="black",lty=1)
lines(predx,predprobs[,2],col="black",lty=2)
lines(predx,predprobs[,3],col="black",lty=2)
legend(x = -60, y = 21, legend=c("Linear Model: 16.7 + 0.0110x, p=0.22"), bty='n', cex=0.9)

plot(data$Margin,data$logCost, col=rgb(0,0,1,0.5), main = "Electorate Spending vs Margin", xlab="Margin (%)", ylab="Log State Gov Spending")
lmfit2<-with(data,lm(logCost~Margin))
summary(lmfit2)
predx2 = seq(min(data$Margin),max(data$Margin))
predprobs2<-predict(lmfit2,data.frame(Margin=predx2),interval="prediction",level = 0.95,type="response")
lines(predx2,predprobs2[,1],col="black",lty=1)
lines(predx2,predprobs2[,2],col="black",lty=2)
lines(predx2,predprobs2[,3],col="black",lty=2)
legend(x = 23, y = 20.5, legend=c("Linear Model: 17.1 - 0.0231x, p=0.126"), bty='n', cex=0.9)

# Plot spurious relationships
plot(data$logCost, data$One_method_Walked_only_P/data$Tot_P, col=rgb(0,0,1,0.5), main = "Unexpected Relationships", xlab="Log State Gov Spending", ylab="Proportion of Population")
#points(data$logCost,data$One_method_Bicycle_P/data$Tot_P, col=rgb(0,0,1,0.5))
#legend("topleft", c("Work by Bicycle", "Work by Walking"),fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))
legend("topleft", c("Work by Walking"),fill=c(rgb(0,0,1,0.5)))
data['lmfitwalking'] = data$One_method_Walked_only_P/data$Tot_P
lmfit<-with(data,lm(logCost~lmfitwalking))
my.min <- function(x) ifelse( !all(is.na(x)), min(x, na.rm=T), NA)
my.max <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)
predx = seq(my.min(data$lmfitwalking),my.max(data$lmfitwalking), by=0.001)
predprobs<-predict(lmfit,data.frame(lmfitwalking=predx),interval="prediction",level = 0.95,type="response")
lines(predprobs[,1],predx,col="black",lty=1)
lines(predprobs[,2],predx,col="black",lty=2)
lines(predprobs[,3],predx,col="black",lty=2)


# Logistic models. Only logfit 1 (isALP) shows statistical significance
plot(data$logCost,data$isALP, col=rgb(0,0,1,0.5), main = "ALP Won vs Log Electorate Spending", xlab="Log State Gov Spending", ylab="ALP Won in 2017")
logfit1 <- glm(isALP~logCost, data=data,family=binomial)
summary(logfit1)
predx = seq(min(data$logCost),max(data$logCost))
predprobs<-predict(logfit1,data.frame(logCost=predx),type="response")
lines(predx,predprobs,col="black",lty=1)
legend(x = 13, y = 0.8, legend=c("Logstic Model: 1/(1 + exp(0.362x)), p=0.0363"), bty='n', cex=0.9)

plot(data$logCost,data$sigmoidMargin)
logfit2 <- glm(sigmoidMargin~logCost, data=data,family=binomial)
summary(logfit2)
predx = seq(min(data$logCost),max(data$logCost))
predprobs<-predict(logfit2,data.frame(logCost=predx),type="response")
lines(predx,predprobs,col="black",lty=1)

plot(safety$logCost,(safety$SafetySwing+safety$SafetyMarginal))
logfit3 <- glm((SafetyMarginal+SafetySwing)~logCost, data=safety,family=binomial)
summary(logfit3)
predx = seq(min(data$logCost),max(data$logCost))
predprobs<-predict(logfit3,data.frame(logCost=predx),type="response")
lines(predx,predprobs,col="black",lty=1)