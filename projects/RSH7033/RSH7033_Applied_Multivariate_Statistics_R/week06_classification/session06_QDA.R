############################################################
# Week 6: Quadratic Discriminant Analysis (QDA)
############################################################

source("setup/install_packages.R")

library(MASS)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")
valid     <- read.csv("data/valid.csv")

############################################################
# Fit QDA Model
############################################################

qda_fit <- qda(good ~ ., data = placekick)

############################################################
# Cross-Validation
############################################################

qda_cv <- qda(good ~ ., data = placekick, CV = TRUE)

############################################################
# Accuracy
############################################################

summarize_class <- function(original, predicted) {
  tab <- table(original, predicted)
  acc <- sum(diag(tab)) / sum(tab)
  acc
}

summarize_class(placekick$good, qda_cv$class)

############################################################
# Validation
############################################################

pred_valid <- predict(qda_fit, newdata = valid)

summarize_class(valid$good, pred_valid$class)
