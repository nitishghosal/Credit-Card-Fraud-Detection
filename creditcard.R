library(rpart)
library(ROSE)
library(rattle)
library(caret)
library(mlbench)
library(caretEnsemble)
library(tidyverse)
mydata <- read.csv("creditcard.csv")
mydata$Class[mydata$Class==1]<- "Yes"
mydata$Class[mydata$Class==0]<- "No"
mydata$Class <- as.factor(mydata$Class)
training_size <- floor(0.80 * nrow(mydata))
train_ind <- sample(seq_len(nrow(mydata)), size = training_size)
training <- mydata[train_ind, ]
testing <- mydata[-train_ind, ]
#CART Model Performance on imbalanced data
fit1 <- rpart(Class~., data = training)
pred.fit1 <- predict(fit1, newdata = testing)
accuracy.meas(testing$Class, pred.fit1[,2])
roc.curve(testing$Class, pred.fit1[,2], plotit = F)
#Undersampling
data_balanced_under <- ovun.sample(Class ~ ., data = training, method = "under", N = 806, seed = 1)$data
table(data_balanced_under$Class)
#Oversampling
data_balanced_over <- ovun.sample(Class ~ ., data = training, method = "over",N = 454884)$data
table(data_balanced_over$Class)
#Both
data_balanced_both <- ovun.sample(Class ~ ., data = training, method = "both", p=0.5, N=10000, seed = 1)$data
table(data_balanced_both$Class)
#SDG
data.rose <- ROSE(Class ~ ., data = training, seed = 1)$data
table(data.rose$Class)
#CART Model with resampling
fit.under <- rpart(Class ~ ., data = data_balanced_under)
fit.over <- rpart(Class ~ ., data = data_balanced_over)
fit.both <- rpart(Class ~ ., data = data_balanced_both)
fit.rose <- rpart(Class ~ ., data = data.rose)
#CART Predictions on resampling methods
pred.under <- predict(fit.under, newdata = testing)
pred.over <- predict(fit.over, newdata = testing)
pred.both <- predict(fit.both, newdata = testing)
pred.rose <- predict(fit.rose, newdata = testing)
#CART AUC on resampling methods
roc.curve(testing$Class, pred.under[,2])
roc.curve(testing$Class, pred.over[,2])
roc.curve(testing$Class, pred.both[,2])
roc.curve(testing$Class, pred.rose[,2])
#Classfication Models
control <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
algorithmList <- c('rpart','glm','lda','knn','svmRadial')
set.seed(2)
models <- caretList(Class~., data=data_balanced_both, trControl=control, methodList=algorithmList)
results <- resamples(models)
summary(results)
dotplot(results)
#Model Correlations
modelCor(results)
splom(results)
#Model Stacking with GLM
stackControl <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
set.seed(3)
stack.glm <- caretStack(models, method="glm", metric="Accuracy", trControl=stackControl)
print(stack.glm)
