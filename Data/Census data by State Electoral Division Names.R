library(tidyverse)
library(readr)
library(readxl)

setwd("D:/Technical document/Master of data science/Sem 2 2020/Intro to Data Science DATA7001/2016 Census GCP State Electoral Divisions for QLD")
SEDdf <- read_excel("SED CODES to NAMES.xlsx")
SED_NAME <- SEDdf$Census_Name_2016
csvfiles <- list.files(pattern = '*.csv', full.names = T)
data_list <- lapply(csvfiles, read.csv, header=T)
df <- do.call(cbind, data_list)
View(df$SED_CODE_2016)
colnames(df)[1]='SED_NAME_2016'
df[,1] <- SED_NAME
df.new <- df[,-grep("_M", colnames(df))]
df.new <- df.new[,-grep("_F", colnames(df.new))]
df.new <- df.new[,-grep("Vis", colnames(df.new))]
write.csv(df.new, 'Combined Census data.csv')
