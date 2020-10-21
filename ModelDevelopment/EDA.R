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
corrPvals = as.data.frame(rcorr(as.matrix(numericData), type="pearson")$P)['logCost']


# Plots and models
plot(data$MarginPower,data$logCost)
lmfit<-with(data,lm(logCost~MarginPower))
summary(lmfit)
plot(data$Margin,data$logCost)
lmfit2<-with(data,lm(logCost~Margin))
summary(lmfit2)

plot(data$logCost,data$isALP)
logfit1 <- glm(isALP~logCost, data=data,family=binomial)
summary(logfit1)
plot(data$logCost,data$sigmoidMargin)
logfit2 <- glm(sigmoidMargin~logCost, data=data,family=binomial)
summary(logfit2)
plot(safety$logCost,(safety$SafetySwing+safety$SafetyMarginal))
logfit3 <- glm((SafetyMarginal+SafetySwing)~logCost, data=safety,family=binomial)
summary(logfit3)