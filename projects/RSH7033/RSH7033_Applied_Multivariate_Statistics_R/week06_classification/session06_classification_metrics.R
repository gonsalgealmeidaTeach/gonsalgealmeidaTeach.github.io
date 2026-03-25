############################################################
# Week 6: Classification Metrics
############################################################

source("setup/install_packages.R")

cutoff <- 0.5

pred <- ifelse(pi_hat > cutoff, 1, 0)
pred_valid <- ifelse(pi_hat_valid > cutoff, 1, 0)

############################################################
# Confusion Matrix Function
############################################################

summarize_class <- function(original, predicted) {
  table <- table(original, predicted)
  accuracy <- sum(diag(table)) / sum(table)
  list(confusion_matrix = table, accuracy = accuracy)
}

summarize_class(placekick$good, pred)
summarize_class(valid$good, pred_valid)
