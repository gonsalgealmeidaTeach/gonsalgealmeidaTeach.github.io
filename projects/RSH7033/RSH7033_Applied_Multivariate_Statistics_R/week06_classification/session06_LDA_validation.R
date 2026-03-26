############################################################
# Week 6: LDA Validation
############################################################

source("setup/install_packages.R")

library(MASS)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")
valid     <- read.csv("data/valid.csv")

############################################################
# Cross-Validation
############################################################

lda_cv <- lda(good ~ ., data = placekick, CV = TRUE)

############################################################
# Accuracy Function
############################################################

summarize_class <- function(original, predicted) {
  tab <- table(original, predicted)
  acc <- sum(diag(tab)) / sum(tab)
  list(confusion_matrix = tab,
       accuracy = acc)
}

summarize_class(placekick$good, lda_cv$class)

############################################################
# Validation Data
############################################################

lda_fit <- lda(good ~ ., data = placekick)

pred_valid <- predict(lda_fit, newdata = valid)

summarize_class(valid$good, pred_valid$class)
