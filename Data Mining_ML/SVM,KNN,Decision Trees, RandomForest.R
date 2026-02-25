#We'll use the "Titanic" dataset, 
#The algorithms we'll use are:

#K-Nearest Neighbors (KNN)
#Decision Trees
#Support Vector Machines (SVM)
#Logistic Regression
#Ensemble Methods (Random Forest)


# Install and load necessary packages
#install.packages("titanic")
#install.packages("e1071")     # For SVM
#install.packages("class")     # For KNN
#install.packages("rpart")     # For Decision Trees
#install.packages("randomForest") # For Random Forest
#install.packages("caTools")   # For splitting the data

library(titanic)
library(e1071)
library(class)
library(rpart)
library(randomForest)
library(caTools)

# Load the Titanic dataset
data("titanic_train")
df <- titanic_train

# View the first few rows of the data
head(df)



##data preprocessing


# Check for missing values
summary(df)

# Drop unnecessary columns (e.g., Name, Ticket, Cabin, PassengerId)
df <- df[, -c(1, 4, 9, 11)]  # Drop PassengerId, Name, Ticket, and Cabin columns

# Handle missing values by replacing missing Age with the median
df$Age[is.na(df$Age)] <- median(df$Age, na.rm = TRUE)

# For Embarked, replace missing values with the most common category (mode)
df$Embarked[is.na(df$Embarked)] <- 'S'

# Convert categorical variables into factors
df$Survived <- as.factor(df$Survived)
df$Pclass <- as.factor(df$Pclass)
df$Sex <- as.factor(df$Sex)
df$Embarked <- as.factor(df$Embarked)

# View the cleaned data
str(df)





#We will split the dataset into 80% training data and 20% testing data

set.seed(123)  # Set seed for reproducibility
split <- sample.split(df$Survived, SplitRatio = 0.8)
train_data <- subset(df, split == TRUE)
test_data <- subset(df, split == FALSE)



######  Train Models Using Different Algorithms ############


#K-Nearest Neighbors (KNN)
#we first need to normalize the numeric features and then train the model

# Ensure the necessary packages are installed and loaded
#install.packages("class")  # For KNN

library(class)

# Step 1: One-Hot Encoding of Categorical Variables
# model.matrix() will handle categorical encoding for us
train_data_encoded <- model.matrix(Survived ~ ., data = train_data)[, -1]
test_data_encoded <- model.matrix(Survived ~ ., data = test_data)[, -1]

# Ensure that both datasets are normalized
normalize <- function(x) { return ((x - min(x)) / (max(x) - min(x))) }

train_data_encoded[, "Age"] <- normalize(train_data_encoded[, "Age"])
train_data_encoded[, "Fare"] <- normalize(train_data_encoded[, "Fare"])
test_data_encoded[, "Age"] <- normalize(test_data_encoded[, "Age"])
test_data_encoded[, "Fare"] <- normalize(test_data_encoded[, "Fare"])

# Step 2: Apply KNN
# Extract the labels (Survived column) for the training set
train_labels <- train_data$Survived

# Apply KNN with k = 5
knn_pred <- knn(train = train_data_encoded, test = test_data_encoded, cl = train_labels, k = 5)

# Step 3: Evaluate KNN performance
knn_accuracy <- mean(knn_pred == test_data$Survived)
print(paste("KNN Accuracy: ", knn_accuracy))



#Decision Tree
# Train a decision tree
dt_model <- rpart(Survived ~ ., data = train_data, method = "class")

# Make predictions on the test set
dt_pred <- predict(dt_model, test_data, type = "class")

# Calculate accuracy
dt_accuracy <- mean(dt_pred == test_data$Survived)
print(paste("Decision Tree Accuracy: ", dt_accuracy))




# SVM

# Train an SVM model
svm_model <- svm(Survived ~ ., data = train_data, kernel = "radial")

# Make predictions on the test set
svm_pred <- predict(svm_model, test_data)

# Calculate accuracy
svm_accuracy <- mean(svm_pred == test_data$Survived)
print(paste("SVM Accuracy: ", svm_accuracy))

# logistic regerssion

# Train a logistic regression model
logistic_model <- glm(Survived ~ ., data = train_data, family = binomial)

# Make predictions on the test set (convert probabilities to class labels)
logistic_pred <- predict(logistic_model, test_data, type = "response")
logistic_pred_class <- ifelse(logistic_pred > 0.5, 1, 0)

# Calculate accuracy
logistic_accuracy <- mean(logistic_pred_class == test_data$Survived)
print(paste("Logistic Regression Accuracy: ", logistic_accuracy))


# Random forest

# Train a Random Forest model
rf_model <- randomForest(Survived ~ ., data = train_data, ntree = 100)

# Make predictions on the test set
rf_pred <- predict(rf_model, test_data)

# Calculate accuracy
rf_accuracy <- mean(rf_pred == test_data$Survived)
print(paste("Random Forest Accuracy: ", rf_accuracy))



#Compare the Accuracy of All Models

# Print accuracy of all models
print(paste("KNN Accuracy: ", knn_accuracy))
print(paste("Decision Tree Accuracy: ", dt_accuracy))
print(paste("SVM Accuracy: ", svm_accuracy))
print(paste("Logistic Regression Accuracy: ", logistic_accuracy))
print(paste("Random Forest Accuracy: ", rf_accuracy))

######## Results #######
# "KNN Accuracy:  0.780898876404494"
# "Decision Tree Accuracy:  0.786516853932584"
# "SVM Accuracy:  0.825842696629214"
# "Logistic Regression Accuracy:  0.775280898876405"
# "Random Forest Accuracy:  0.831460674157303"
# "KNN Accuracy:  0.780898876404494"
# "Decision Tree Accuracy:  0.786516853932584"
# "SVM Accuracy:  0.825842696629214"
# "Logistic Regression Accuracy:  0.775280898876405"
# "Random Forest Accuracy:  0.831460674157303"