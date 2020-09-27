library(readr)
abs_levelofEducation <- read_csv("C:/Users/siamak/Desktop/Siamak/UQ/DATA7001/myDATA/ABS_CENSUS2011_B40_LGA_14092020020017874.csv")


library(dplyr)
filtered_queensland <- filter(abs_levelofEducation,abs_levelofEducation$State =="Queensland")
filtered_queensland$`LGA 2011` 
asd <- filter(filtered_queensland,filtered_queensland$`LGA 2011` =="Bulloo (S)")
summary (filtered_queensland$`LGA 2011`)
colnames (filtered_queensland)
unique (filtered_queensland$`Non-School Qualification: Level of Education`)

library(readr)
population <- read_csv("C:/Users/siamak/Desktop/population.csv")
income <- read_csv("C:/Users/siamak/Desktop/income.csv")
education <- read_csv("C:/Users/siamak/Desktop/education.csv")
citizenship <- read_csv("C:/Users/siamak/Desktop/citizenship.csv")

new_function <- function(a){
code <- a

population_1 <- filter(population,population$`Australian Bureau of Statistics`== code) 

income_1 <- filter(income,income$`Australian Bureau of Statistics` == code) 

education_1 <- filter(education,education$`Australian Bureau of Statistics` == code) 
education_2 <- education_1
education_2[nrow(education_2) + 1, ] <- "0"
education_2$X3 == "2019"

citizenship_1 <- filter(citizenship,citizenship$`Australian Bureau of Statistics` == code) 
citizenship_1$X6 <- as.numeric(citizenship_1$X6)
citizenship_1$X30 <- as.numeric(citizenship_1$X30)



table_frame <-  data.frame(population_1$`Australian Bureau of Statistics`,population_1$X3,population_1$X11,income_1$X6,
                           education_2$X15)
colnames (table_frame) <- cbind ("code","year","Persons - Total (no.)","Total employee income ($m)","Number of Jobs - Persons")
return (table_frame)
}

region_code_1 <- filter(population,population$`Australian Bureau of Statistics`>30000)
region_code_2   <- filter(region_code_1,region_code_1$`Australian Bureau of Statistics`<40000)              
                      
region_code <- unique(region_code_2$`Australian Bureau of Statistics`)
region_code 

region_code 
aaa[[1]]<-  new_function(30250)
aaa[[2]] <- new_function(30300)
aaa[[3]] <- new_function(30410)
a4 <- new_function(30370)
a5 <- new_function(30450)
a6 <- new_function(30760)
a7 <- new_function(30900)
a8 <- new_function(31000)
a9 <- new_function(31750)
a10 <- new_function(31820)
a11 <- new_function(31900)
a12 <- new_function(31950)
a13 <- new_function(32080)
a14 <- new_function(32250)
a15 <- new_function(32260)
a16 <- new_function(32270)
a17 <- new_function(32310)
a18 <- new_function(32330)
a19 <- new_function(32450)
a20 <- new_function(32500)
a21 <- new_function(32600)
a22 <- new_function(32750)

new_data_frame <-  rbind (aaa[[1]], aaa[[2]][-1,],aaa[[3]][-1,],a4[-1,],
                          a5[-1,],a6[-1,],a7[-1,],a8[-1,],a9[-1,],
                          a10[-1,],a11[-1,],a12[-1,],a13[-1,],a14[-1,],a15[-1,],
                          a16[-1,],a17[-1,],a18[-1,],a19[-1,],a20[-1,],a21[-1,],
                          a22[-1,])
new_data_frame 

new_function(31950)
