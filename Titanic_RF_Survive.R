## Install & Load tools into Workspace
install.packages("tree")
install.packages("randomForest")
library(dplyr)
library(randomForest)



#Read data in 
train_data = (read.csv("C:\\Users\\shaki\\Downloads\\titanic\\train.csv"))
head(train_data)
test_data = (read.csv(("C:\\Users\\shaki\\Downloads\\titanic\\test.csv")))
head(test_data)

#Analysis 
  #Women who Survived
women_survived = subset(train_data, Sex =="female" & Survived == 1)
women = subset(train_data, Sex == "female")
head(women)
rate_women = 100*(nrow(women_survived) / nrow(women))
rate_women
print(paste("% of women who survived: ", rate_women))
  ##~75.47% of women survived

  #Men who Survived
men_survived = subset(train_data, Sex =="male" & Survived == 1)
men = subset(train_data, Sex == "male")
rate_men = 100*(nrow(men_survived) / nrow(men))
rate_men
print(paste("% of men who survived: ", rate_men))
  ##~20.52% of men survived

## RF Model 
train_data$Survived = as.factor(train_data$Survived)
rf_model = randomForest (Survived~Pclass + Sex + SibSp + Parch, data = train_data, importance = TRUE, method = 'rf')
rf_model
##~79% Success Rate 

## Prediction
test_Survived = predict(rf_model, newdata = test_data)
str(test_Survived)

test_survived_c = as.character(test_Survived)
head(test_survived_c)

test_pid = as.numeric(test_data$PassengerId)
test_pid

### Output 
length(test_survived_c)
length(test_pid)

output_df = data.frame(test_pid,test_survived_c)
colnames(output_df) = c("PassengerID", "Survived")
head(output_df)


## Export
write.csv(output_df, "C:\\Users\\shaki\\Desktop\\titantic_rf_survive.csv", row.names = FALSE)
