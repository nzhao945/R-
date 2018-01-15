# 本项目需要加载的包
library(data.table)
library(dplyr)
library(mice)
library(VIM)
library(ggplot2)
library(randomForest)

#导入训练集和测试集
train <- fread(header = T, stringsAsFactors = F,
                file = "G:/R/kaggle_data/Titanic Machine Learning from Disaster/train.csv")
test <- fread(header = T, stringsAsFactors = F,
                file = "G:/R/kaggle_data/Titanic Machine Learning from Disaster/test.csv")

#探究数据集
str(train)
train <- train %>% mutate(Survived = factor(Survived),Pclass = factor(Pclass),
                          Embarked = factor(Embarked),Sex = factor(Sex))
str(test)
test <- test %>% mutate(Pclass = factor(Pclass),Embarked = factor(Embarked),Sex = factor(Sex))

# 发现部分缺失值并没有被读取为NA，而是""，所以作如下操作
train$Embarked[train$Embarked==""] <- NA
train$Cabin[train$Cabin==""] <- NA

# 合并train和test,test中不存在的列Survived由参数fill=T生成NA
comb <- rbind(train,test, fill = T)

#缺失值可视化
aggr(train, prop = FALSE, combined = TRUE, numbers = TRUE, sortVars = TRUE, sortCombs = TRUE)