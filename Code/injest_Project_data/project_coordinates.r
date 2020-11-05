
library(readr)
library(sf)
library(cran)
library(maptools)
library(plotKML)

library(RCurl)
library(RJSONIO)
library(plyr)
library(ggmap)

projects <- read.csv("https://www.data.qld.gov.au/dataset/b518dada-3d2a-4d85-bd2c-febe197863c7/resource/410fb21f-8c5a-43a1-8b57-a74a3329d1d0/download/ops-open-data.csv")

View(projects)

colnames(projects)

dd=strsplit(projects[1,'ï..Project.Title'],',')

?strsplit

class(dd)
class(dd[[1]])
typeof(dd[[1]])
dd[[1]][1]


projects$latitude=0
projects$longitude=0
register_google(key = "")


for (row in 1:nrow(projects)) {
  
  projectName=projects[row,'ï..Project.Title']
  splitName=strsplit(projectName,',')
  address=paste(splitName[[1]][1],',',splitName[[1]][2],'QLD, Australia')
  
  print(address)
  
  out <- tryCatch(
    {
      
      googleResult <-geocode(c(address), output = "all")
      
      if (googleResult$status=="OK")
      {
        projects[row,'latitude']= googleResult[[1]][[1]]$geometry$location$lat
        projects[row,'longitude']= googleResult[[1]][[1]]$geometry$location$lng
      }
      
    },
    error=function(cond) {
      message("URL does not seem to exist:")
      message("Here's the original error message:")
      message(cond)
      # Choose a return value in case of error
      return(NA)
    },
    warning=function(cond) {
      message("URL caused a warning:")
      message("Here's the original warning message:")
      message(address)
      message(cond)
      # Choose a return value in case of warning
      return(NULL)
    },
    finally={
      # NOTE:
      # Here goes everything that should be executed at the end,
      # regardless of success or error.
      # If you want more than one expression to be executed, then you 
      # need to wrap them in curly brackets ({...}); otherwise you could
      # just have written 'finally=<expression>' 
      message("Processed URL:")
      message("Some other message at the end")
    }
  ) 
  
}
googleResult
View(projects)


write.csv(projects,"D:/Users/crist/Documents/GitHub/Data7001_Group8/Webtool/Data7001WebTool/wwwroot/data/QLD_Projects.csv", row.names = TRUE)


