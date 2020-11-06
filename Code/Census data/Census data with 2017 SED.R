library(readr)
library(dplyr)
Census2 <- read_csv("Census2.csv")

# Changing Electorate names from 2016 to 2017 equivalent
Census2$Electorate[Census2$Electorate=="Ashgrove"]="Cooper"
Census2$Electorate[Census2$Electorate=="Dalrymple"]="Hill"
Census2$Electorate[Census2$Electorate=="Kallangur"]="Kurwongbah"
Census2$Electorate[Census2$Electorate=="Mount Coot-tha"]="Maiwar"
Census2$Electorate[Census2$Electorate=="Brisbane Central"]="McConnel"
Census2$Electorate[Census2$Electorate=="Cleveland"]="Oodgeroo"
Census2$Electorate[Census2$Electorate=="Beaudesert"]="Scenic Rim"
Census2$Electorate[Census2$Electorate=="Albert"]="Theodore"
Census2$Electorate[Census2$Electorate=="Sunnybank"]="Toohey"
Census2$Electorate[Census2$Electorate=="Mount Isa"]="Traeger"

# Create new 2017 Electorates (based on inheriting electorates). Method: averaging values

bonney <- rbind.data.frame(Census2[Census2[,1]=='Southport',],
                           Census2[Census2[,1]=='Broadwater',])
bonney_data <- c('Bonney', apply(bonney[,-c(1)], 2, mean))

bancroft <- rbind.data.frame(Census2[Census2[,1]=='Murrumba',],
                           Census2[Census2[,1]=='Kurwongbah',],
                           Census2[Census2[,1]=='Morayfield',],
                           Census2[Census2[,1]=='Pumicestone',])
bancroft_data <- c('Bancroft', apply(bancroft[,-c(1)], 2, mean))

jordan <- rbind.data.frame(Census2[Census2[,1]=='Bundamba',],
            Census2[Census2[,1]=='Inala',],
            Census2[Census2[,1]=='Algester',],
            Census2[Census2[,1]=='Lockyer',],
            Census2[Census2[,1]=='Logan',])
jordan_data <- c('Jordan', apply(jordan[,-c(1)], 2, mean))

macalister <- rbind.data.frame(Census2[Census2[,1]=='Waterford',],
                           Census2[Census2[,1]=='Coomera',],
                           Census2[Census2[,1]=='Redlands',])
macalister_data <- c('Macalister', apply(macalister[,-c(1)], 2, mean))

miller <- rbind.data.frame(Census2[Census2[,1]=='Indooroopilly',],
                               Census2[Census2[,1]=='Yeerongpilly',])
miller_data <- c('Miller', apply(macalister[,-c(1)], 2, mean))

ninderry <- rbind.data.frame(Census2[Census2[,1]=='Noosa',],
                           Census2[Census2[,1]=='Nicklin',],
                           Census2[Census2[,1]=='Buderim',],
                           Census2[Census2[,1]=='Maroochydore',])
ninderry_data <- c('Ninderry', apply(jordan[,-c(1)], 2, mean))

Census2 <- rbind(Census2, bonney_data, bancroft_data, jordan_data, macalister_data, miller_data, ninderry_data)
Census2 <- Census2 %>% 
  filter(Census2[,1]!="Indooroopilly" & Census2[,1]!="Yeerongpilly")
Census2 <- mutate_all(Census2, .funs=toupper)

Electorate_enrolment <- read.csv('ELECTORATE ENROLMENT 2016.csv')
Electorate_enrolment <- Electorate_enrolment[,1:2]

Census2 <- cbind(Census2, Electorate_enrolment)
Census2 <- Census2[,-c(50)]

write.csv(Census2, 'Census_3_Corrected SED.csv')
