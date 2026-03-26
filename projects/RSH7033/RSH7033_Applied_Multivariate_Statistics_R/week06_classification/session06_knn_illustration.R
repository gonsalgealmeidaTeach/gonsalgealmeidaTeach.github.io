############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 6: KNN Illustration (4 Observations Example)
############################################################

# Load setup
source("setup/install_packages.R")

library(class)

############################################################
# 1. Simple Dataset
############################################################

set1 <- data.frame(
  x1  = c(0, 0, 1, 1),
  x2  = c(0, 1, 0, 1),
  pop = c(1, 1, 2, 2)
)

set1

############################################################
# 2. Visualization
############################################################

plot(set1$x1, set1$x2,
     xlab = expression(x[1]),
     ylab = expression(x[2]),
     xlim = c(-0.5, 1.5),
     ylim = c(-0.5, 1.5),
     pch = set1$pop,
     col = set1$pop)

grid()

legend("top",
       legend = c("Pop. 1", "Pop. 2"),
       col = c(1, 2),
       pch = c(1, 2),
       bty = "n")

text(set1$x1, set1$x2 + 0.1, labels = 1:nrow(set1))

############################################################
# 3. Distance Matrix
############################################################

dist.mat <- dist(set1[,1:2])
dist.mat

############################################################
# 4. KNN Classification (Training Data)
############################################################

knn_k1 <- knn(train = set1[,1:2],
              test  = set1[,1:2],
              cl    = set1$pop,
              k     = 1)

knn_k2 <- knn(set1[,1:2], set1[,1:2], set1$pop, k = 2)
knn_k3 <- knn(set1[,1:2], set1[,1:2], set1$pop, k = 3)
knn_k4 <- knn(set1[,1:2], set1[,1:2], set1$pop, k = 4)

data.frame(set1, k1 = knn_k1, k2 = knn_k2, k3 = knn_k3, k4 = knn_k4)

############################################################
# 5. Cross-Validation (LOOCV)
############################################################

knn_cv1 <- knn.cv(set1[,1:2], set1$pop, k = 1)
knn_cv2 <- knn.cv(set1[,1:2], set1$pop, k = 2)
knn_cv3 <- knn.cv(set1[,1:2], set1$pop, k = 3)

data.frame(set1, cv_k1 = knn_cv1, cv_k2 = knn_cv2, cv_k3 = knn_cv3)

############################################################
# 6. Validation Example
############################################################

add.numb <- 0.6

valid <- data.frame(
  x1  = set1$x1 + add.numb,
  x2  = set1$x2 + add.numb,
  pop = set1$pop
)

valid

############################################################
# Plot Training + Validation
############################################################

plot(set1$x1, set1$x2,
     xlim = c(-0.5, 2),
     ylim = c(-0.5, 2),
     pch = set1$pop,
     col = set1$pop)

points(valid$x1, valid$x2,
       col = valid$pop,
       pch = valid$pop)

grid()

############################################################
# Predict Validation Data
############################################################

pred_valid <- knn(train = set1[,1:2],
                  test  = valid[,1:2],
                  cl    = set1$pop,
                  k     = 1)

pred_valid

points(valid$x1, valid$x2,
       col = as.numeric(pred_valid),
       pch = as.numeric(pred_valid),
       cex = 1.5)

############################################################
# 7. Accuracy Function
############################################################

summarize_class <- function(original, predicted) {
  tab <- table(original, predicted)
  accuracy <- sum(diag(tab)) / sum(tab)
  list(confusion_matrix = tab,
       accuracy = accuracy)
}

summarize_class(valid$pop, pred_valid)

############################################################
# Interpretation
############################################################

# KNN assigns class based on nearest neighbors
# Small k → sensitive to noise
# Large k → smoother decision boundary
