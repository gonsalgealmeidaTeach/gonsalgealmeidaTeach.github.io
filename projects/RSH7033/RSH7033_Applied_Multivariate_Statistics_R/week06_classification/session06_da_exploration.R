############################################################
# Week 6: Discriminant Analysis – Exploration
############################################################

source("setup/install_packages.R")

library(MASS)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")

############################################################
# PCA Visualization
############################################################

pca <- princomp(placekick[,-9], cor = TRUE)

scores <- predict(pca)

col <- ifelse(placekick$good == 1, "red", "black")

plot(scores[,1], scores[,2],
     col = col,
     xlab = "PC1", ylab = "PC2",
     main = "PCA: Success vs Failure")

legend("bottomleft",
       legend = c("Success", "Failure"),
       col = c("red","black"),
       pch = 1)
