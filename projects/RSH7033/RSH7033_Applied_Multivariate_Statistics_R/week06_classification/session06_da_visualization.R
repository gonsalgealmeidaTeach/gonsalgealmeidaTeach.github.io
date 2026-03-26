############################################################
# Week 6: DA Visualization (PCA Space)
############################################################

source("setup/install_packages.R")

library(MASS)
library(rgl)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")

############################################################
# PCA
############################################################

pca <- princomp(placekick[,-9], cor = TRUE)

scores <- predict(pca)

############################################################
# LDA Classification
############################################################

lda_fit <- lda(good ~ ., data = placekick)

pred <- predict(lda_fit)$class

col <- ifelse(pred == 1, "red", "black")

############################################################
# 2D Plot
############################################################

plot(scores[,1], scores[,2],
     col = col,
     xlab = "PC1", ylab = "PC2",
     main = "LDA Classification in PCA Space")

abline(h = 0)
abline(v = 0)

############################################################
# 3D Plot
############################################################

plot3d(scores[,1], scores[,2], scores[,3],
       col = col,
       xlab = "PC1", ylab = "PC2", zlab = "PC3")
