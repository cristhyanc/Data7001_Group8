
setwd("C:/Users/siamak/Desktop/Project")
dir()
data<-read.csv("combined.csv")
View(data)


# The first thing that you should do is check the class of your data frame:
class(data)
dim(data)
summary (data)

install.packages("dplyr")
library(dplyr)
glimpse (data)
sum (!complete.cases(data))
data2 <- data[,-2]
data2 <- data[,27:46]
data1 <- data.frame(data2,data$BUDGET,data$Tot_Population,data$Unemploy)
df <- filter(data1,data$One_method_Train_P!= "na")

glimpse (df)

#Visualize correlation matrix using correlogram

install.packages(corrplot) 
library(corrplot)

M<-cor(df) 
head(round(M,2))
corrplot(M, type = "upper", order = "hclust", 
         tl.col = "black")


# to the native R cor.test function 
cor.mtest <- function(mat, ...)  
{ 
  mat <- as.matrix(mat) 
  n <- ncol(mat) 
  p.mat<- matrix(NA, n, n) 
  diag(p.mat) <- 0 
  for (i in 1:(n - 1))  
  { 
    for (j in (i + 1):n) 
    { 
      tmp <- cor.test(mat[, i], mat[, j], ...) 
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value 
    } 
  } 
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat) 
  p.mat 
} 

# matrix of the p-value of the correlation 
p.mat <- cor.mtest(df) 
head(p.mat[, 1:5])

corrplot(M, type = "upper", order = "hclust",  
         p.mat = p.mat, sig.level = 0.01) 


col <- colorRampPalette(c("#BB4444", "#EE9988",  
                          "#FFFFFF", "#77AADD", 
                          "#4477AA")) 

corrplot(M, method = "color", col = col(300),   
         type = "upper", order = "hclust",  
         addCoef.col = "black", 
         tl.col="black",
         p.mat = p.mat, sig.level = 0.01, 
         diag = FALSE 
)

