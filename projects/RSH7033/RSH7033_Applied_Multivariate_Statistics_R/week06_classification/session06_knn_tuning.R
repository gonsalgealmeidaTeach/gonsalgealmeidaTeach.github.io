############################################################
# Week 6: KNN Model Tuning (Choosing K)
############################################################

source("setup/install_packages.R")

library(class)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")
valid     <- read.csv("data/valid.csv")

X <- placekick[,-9]
Y <- placekick[,9]

Z <- scale(X)

Z.v <- scale(valid[,-9],
             center = colMeans(X),
             scale  = apply(X, 2, sd))

############################################################
# Accuracy Function
############################################################

summarize_class <- function(original, predicted) {
  tab <- table(original, predicted)
  accuracy <- sum(diag(tab)) / sum(tab)
  return(accuracy)
}

############################################################
# Evaluate Different K
############################################################

results <- data.frame(K = 1:10,
                      Validation = NA,
                      CV = NA)

for (k in 1:10) {
  
  pred_valid <- knn(Z, Z.v, Y, k = k)
  pred_cv    <- knn.cv(Z, Y, k = k)
  
  results$Validation[k] <- summarize_class(valid[,9], pred_valid)
  results$CV[k]         <- summarize_class(Y, pred_cv)
}

results

############################################################
# Plot Results
############################################################

plot(results$K, results$Validation,
     type = "o", col = "red",
     ylim = c(0,1),
     xlab = "K", ylab = "Accuracy",
     main = "KNN Accuracy")

lines(results$K, results$CV, col = "blue")

legend("bottomright",
       legend = c("Validation", "Cross-validation"),
       col = c("red","blue"),
       lty = 1)
