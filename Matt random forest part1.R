library(dplyr)
install.packages("caret")
install.packages("rpart")
library(ggplot2)
library(rpart)
library(randomForest)
library(heuristica)

setwd("Prediction Project")
Data<- "training.csv"
Table <- read.csv(Data)
View(Table)
Test<- "testing.csv"
Testt <- read.csv(Test)
View(Testt)

#delete columns that only contain NA
Testc <- Testt[, colSums(is.na(Testt)) != nrow(Testt)]
Testc2 <- Testc[, -3:-6]
Testc2 <- Testc2[, -1]



#create a value that contains the answers to the training set 
Answer <- Table[, 160]




#find which columns are now in both Table and Testc
Colc <- intersect(colnames(Table), colnames(Testc2))



#get rid of columns that contain 
Tablec <- Table[, Colc]
Testc3 <- Testc2[, Colc]

View(Tablec)

View(Testc3)
#add answers back into table 
Tablec2 <- cbind(Tablec, Answer)

# remove unwanted data frames 

rm(Testt)
rm(Table)
rm(Testc2)
rm(Testc)

#split Table data into a train and testing index 

Training1 <- sample(1:nrow(Tablec2), size= .8* nrow(Tablec2))

TrainingData <- Tablec2[Training1, ]
TestData <- Tablec2[-Training1, ]

set.seed(2224)
TrainD1 <- randomForest(Answer ~ . , data= TrainingData, importance= T, ntree=100, mtry = 20)

Predict1 <- predict(TrainD1, TestData)


Solution <- predict(TrainD1, Testc3)

View(CMatrix)
View(Solution)



