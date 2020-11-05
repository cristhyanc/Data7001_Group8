library(Hmisc)
library(tidyverse)
library(dplyr)
library(car)
library(gvlma)

# Census data
census <- read.csv("Census_3_Corrected SED.csv", header = TRUE)
census <- census[,-1]

# Project cost data
project <- read.csv('projectscsv.csv', header = T)
projectSum <- project %>% 
  group_by(Electorate) %>% 
  summarise(TotalEstimatedCost=sum(TotalEstimatedCost))
projectSum <- projectSum[-78,]
projectSum$Electorate <- toupper(projectSum$Electorate)

# Election result data
party <- read.csv("election_results_two_preferred.csv", header = F)
party <- party[party[1]==2017,]
party <- party[party[3]!="Total" & party[3]!='Exhausted',]
partydf <- party %>% 
  group_by(V2) %>% 
  mutate(Voteperc=V4/sum(V4))
colnames(partydf) <- c('Year', 'Electorate', 'Party', 'Votes', 'VotePerc')
# Identify if ALP won the electorate
partydf <- partydf %>% 
  group_by(Electorate) %>% 
  mutate(Margin=VotePerc-min(VotePerc)) %>% 
  mutate(isALP = ifelse(Margin>0 & Party=='ALP',1,0))

partydf_isALP <- partydf %>% 
  filter(isALP==1) %>% 
  mutate(Safety = ifelse(Margin>0.1, 0, 
                         ifelse((Margin>0.06 & Margin<=0.1), 1, 2))) %>% 
  mutate(ALP_Safety_Ranking = Safety)
partydf_notALP <- partydf%>% 
  filter(isALP==0) %>% 
  group_by(Electorate) %>% 
  mutate(Safety = ifelse(Party=='ALP', 0,
                          ifelse(Margin>0.1, 5,
                                 ifelse(Margin<=0.1 & Margin >0.06, 4,
                                        ifelse(Margin == 0, 1, 
                                               ifelse(Margin<=0.06, 3, NA))))))
partydf_notALP <- partydf_notALP %>% 
  group_by(Electorate) %>% 
  mutate(ALP_Safety_Ranking = ifelse(sum(Safety)>5, 5, 
                                     ifelse(sum(Safety)==1, 0, sum(Safety))))
partydf_notALP <- partydf_notALP %>% 
  filter(Margin!=0)

# Election data with isALP and ALP_Safety_Ranking
newpartydf <- rbind(partydf_isALP, partydf_notALP)
newpartydf <- newpartydf[,-c(1,3,4,5,8)]
newpartydf$Electorate <- toupper(newpartydf$Electorate)

combined <- merge(merge(census, newpartydf, all = F), projectSum, all=F)
write.csv(combined, 'combined3.csv')
data <- combined
data$logCost <- log(data$TotalEstimatedCost)
attach(data)

# EDA
boxplot(TotalEstimatedCost)
hist(TotalEstimatedCost, freq = F)
boxplot(logCost)
plot(density(logCost), col='red')
hist(logCost, freq = F, add=T)

xyplot(logCost~Enrolment)
xyplot(logCost~Tot_Population)
xyplot(logCost~Working_Age) # Potential
xyplot(logCost~Retired)
xyplot(logCost~Under_Age)
xyplot(logCost~log(Median_rent_weekly))
xyplot(logCost~log(Median_tot_fam_inc_weekly)) # Potential
xyplot(logCost~Tot_P_Need_for_Asstn)
xyplot(logCost~Ave_Motor_Vehicle_per_Dwelling)
xyplot(logCost~Full_time_Employ) # Potential
xyplot(logCost~Unemploy)
xyplot(logCost~isALP) # Good relationship
xyplot(logCost~ALP_Safety_Ranking) # Potential negative relationship
xyplot(logCost~Margin)

#Linear model:
df_new <- data[,-c(1,54)]
model1 <- glm(logCost~., data = df_new)
summary(model1)

# Linear with logarithmic transformation of Y
model2 <- lm(logCost~Working_Age+Retired+log(Median_tot_fam_inc_weekly)+Full_time_Employ+isALP+ALP_Safety_Ranking+Margin)
summary(model2)
mod.resid <- resid(model2)
plot(model2)
qqnorm(mod.resid)
qqline(mod.resid, col='red')
plot(x=fitted(model2), y=mod.resid, main = "Residual vs Fitted Plot",
     xlab = "Fitted Values", ylab = "Residual")
abline(0,0,col="red")
plot(x=fitted(model2), y=data$logCost, main = "Fitted vs Actual Plot",
     xlab = "Fitted Values", ylab = "Actual")
abline(0,1,col="red")
plot(mod.resid, ylab = "Residual")
abline(0,0,col="red")
gvlma.lm <- gvlma(model2)
summary(gvlma.lm)

# GLM with gamma function
gamma.model <- glm(logCost~Working_Age+isALP+ALP_Safety_Ranking, family = gaussian())
summary(gamma.model)
