############################################################
# Week 6: KNN Classification (Placekick Data)
############################################################

source("setup/install_packages.R")

library(class)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")
valid     <- read.csv("data/valid.csv")

############################################################
# Standardization
############################################################

X <- placekick[,-9]
Y <- placekick[,9]

Z <- scale(X)

Z.v <- scale(valid[,-9],
             center = colMeans(X),
             scale  = apply(X, 2, sd))

############################################################
# KNN Model (K = 1)
############################################################

set.seed(123)

knn_pred <- knn(train = Z,
                test  = Z.v,
                cl    = Y,
                k     = 1)

############################################################
# Accuracy Function
############################################################

summarize_class <- function(original, predicted) {
  tab <- table(original, predicted)
  accuracy <- sum(diag(tab)) / sum(tab)
  list(confusion_matrix = tab,
       accuracy = accuracy)
}

summarize_class(valid[,9], knn_pred)
