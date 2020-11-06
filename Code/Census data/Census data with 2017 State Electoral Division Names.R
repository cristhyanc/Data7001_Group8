library(tidyverse)
library(readr)
library(readxl)
library(dplyr)

setwd("~/GitHub/Data7001_Group8/Code/Census data")
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
colnames(df)[1]='Electorate'
df[,1] <- SED_NAME
df <- df[,-grep("SED_CODE", colnames(df))]
df <- df[-c(90,91),]
colnames(df)[2]='Tot_Population'
colnames(df)[8]='Tot_P_Need_for_Asstn' # People with disability
colnames(df)[9]='Ave_Motor_Vehicle_per_Dwelling'

# Changing Electorate names from 2016 to 2017 equivalent
df$Electorate[df$Electorate=="Ashgrove"]="Cooper"
df$Electorate[df$Electorate=="Dalrymple"]="Hill"
df$Electorate[df$Electorate=="Kallangur"]="Kurwongbah"
df$Electorate[df$Electorate=="Mount Coot-tha"]="Maiwar"
df$Electorate[df$Electorate=="Brisbane Central"]="McConnel"
df$Electorate[df$Electorate=="Cleveland"]="Oodgeroo"
df$Electorate[df$Electorate=="Beaudesert"]="Scenic Rim"
df$Electorate[df$Electorate=="Albert"]="Theodore"
df$Electorate[df$Electorate=="Sunnybank"]="Toohey"
df$Electorate[df$Electorate=="Mount Isa"]="Traeger"

# Create new 2017 Electorates (based on inheriting electorates). Method: averaging values

bonney <- rbind.data.frame(df[df[,1]=='Southport',],
                           df[df[,1]=='Broadwater',])
bonney_data <- c('Bonney', apply(bonney[,-c(1)], 2, mean))

bancroft <- rbind.data.frame(df[df[,1]=='Murrumba',],
                             df[df[,1]=='Kurwongbah',],
                             df[df[,1]=='Morayfield',],
                             df[df[,1]=='Pumicestone',])
bancroft_data <- c('Bancroft', apply(bancroft[,-c(1)], 2, mean))

jordan <- rbind.data.frame(df[df[,1]=='Bundamba',],
                           df[df[,1]=='Inala',],
                           df[df[,1]=='Algester',],
                           df[df[,1]=='Lockyer',],
                           df[df[,1]=='Logan',])
jordan_data <- c('Jordan', apply(jordan[,-c(1)], 2, mean))

macalister <- rbind.data.frame(df[df[,1]=='Waterford',],
                               df[df[,1]=='Coomera',],
                               df[df[,1]=='Redlands',])
macalister_data <- c('Macalister', apply(macalister[,-c(1)], 2, mean))

miller <- rbind.data.frame(df[df[,1]=='Indooroopilly',],
                           df[df[,1]=='Yeerongpilly',])
miller_data <- c('Miller', apply(macalister[,-c(1)], 2, mean))

ninderry <- rbind.data.frame(df[df[,1]=='Noosa',],
                             df[df[,1]=='Nicklin',],
                             df[df[,1]=='Buderim',],
                             df[df[,1]=='Maroochydore',])
ninderry_data <- c('Ninderry', apply(jordan[,-c(1)], 2, mean))

df <- rbind(df, bonney_data, bancroft_data, jordan_data, macalister_data, miller_data, ninderry_data)
df <- df %>% 
  filter(df[,1]!="Indooroopilly" & df[,1]!="Yeerongpilly")
df <- mutate_all(df, .funs=toupper)

Electorate_enrolment <- read.csv('ELECTORATE ENROLMENT 2016.csv')
Electorate_enrolment <- Electorate_enrolment[,1:2]

df <- cbind(df, Electorate_enrolment)
df <- df[,-c(50)]

write.csv(df, 'Census_3_Corrected SED.csv')