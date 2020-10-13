library(tidyverse)
library(readr)
library(readxl)

setwd("D:/Technical document/Master of data science/Sem 2 2020/Intro to Data Science DATA7001/2016 Census GCP State Electoral Divisions for QLD/Data")
SEDdf <- read_excel("SED CODES to NAMES.xlsx")
SED_NAME <- SEDdf$Census_Name_2016

# Demographic data
df1 <- read.csv('2016Census_G01_QLD_SED.csv')
df1 <- df1[,-grep("_M", colnames(df1))]
df1 <- df1[,-grep("_F", colnames(df1))]
df1 <- df1[,-c(14:37)]
df1$Under_Age <- rowSums(df1[, c(3:5)])/df1$Tot_P_P # Proportion of ppl age 0-19
df1$Working_Age <- rowSums(df1[, c(6:10)])/df1$Tot_P_P # Proportion of ppl age 20-64
df1$Retired <- rowSums(df1[, c(11:13)])/df1$Tot_P_P # Proportion of ppl above 65

df2 <- read.csv('2016Census_G02_QLD_SED.csv')
df2 <- df2[,-c(2:4,7:9)]

df3 <- read.csv('2016Census_G18_QLD_SED.csv')
df3 <- df3[,145]

df4 <- read.csv ('2016Census_G30_QLD_SED.csv')
df4$Ave_MV_per_dwelling <- (df4[,3] + df4[,4]*2 + df4[,5]*3 + df4[,6]*4)/df4[,7]

df5 <- read.csv('2016Census_G40_QLD_SED.csv')
df5 <- df5[,-grep("_M", colnames(df5))]
df5 <- df5[,-grep("_F", colnames(df5))]
df5 <- df5[,-grep("Migtn", colnames(df5))]
df5 <- df5[,-grep("Mign", colnames(df5))]
df5$Full_time_Employ <- df5$lfs_Emplyed_wrked_full_time_P/df5$lfs_Tot_LF_P
df5$Part_time_Employ <- df5$lfs_Emplyed_wrked_part_time_P/df5$lfs_Tot_LF_P
df5$Employ_away_from_work <- df5$lfs_Employed_away_from_work_P/df5$lfs_Tot_LF_P
df5$Unemploy <- df5$lfs_Unmplyed_lookng_for_wrk_P/df5$lfs_Tot_LF_P


df6 <- read.csv('2016Census_G59_QLD_SED.csv')
df6 <- df6[,-grep("_M", colnames(df6))]
df6 <- df6[,-grep("_F", colnames(df6))]
df6 <- df6[,-c(30:32)]

df <- cbind(df1[,-c(3:13)], df2[,c(2,3)], df3, df4$Ave_MV_per_dwelling, df5[,c(12:22)], df6)
colnames(df)[1]='SED_NAME_2016'
df[,1] <- SED_NAME
df <- df[,-grep("SED_CODE", colnames(df))]
df <- df[-c(90,91),]
colnames(df)[2]='Tot_Population'
colnames(df)[8]='Tot_P_Need_for_Asstn' # People with disability
colnames(df)[9]='Ave_Motor_Vehicle_per_Dwelling'
write.csv(df, 'Combined data/Combined Census data.csv')

