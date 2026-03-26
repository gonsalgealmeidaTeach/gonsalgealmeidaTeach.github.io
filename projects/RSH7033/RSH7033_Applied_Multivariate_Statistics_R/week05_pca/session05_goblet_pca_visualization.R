############################################################
# Week 5: Goblet PCA Visualization
############################################################

source("setup/install_packages.R")

library(rgl)

############################################################
# Load Data
############################################################

goblet <- read.csv("data/goblet.csv")

goblet2 <- data.frame(
  ID = goblet$goblet,
  w1 = goblet$x1 / goblet$x3,
  w2 = goblet$x2 / goblet$x3,
  w4 = goblet$x4 / goblet$x3,
  w5 = goblet$x5 / goblet$x3,
  w6 = goblet$x6 / goblet$x3
)

############################################################
# PCA (Correlation Matrix)
############################################################

pca.cor <- princomp(~ w1 + w2 + w4 + w5 + w6,
                    data = goblet2,
                    cor = TRUE)

scores <- predict(pca.cor, newdata = goblet2)

############################################################
# 2D Plot
############################################################

plot(scores[,1], scores[,2],
     xlab = "PC1", ylab = "PC2",
     main = "PCA Scatter Plot")

abline(h = 0)
abline(v = 0)

############################################################
# Bubble Plot
############################################################

PC3 <- scores[,3] - min(scores[,3])

symbols(scores[,1], scores[,2],
        circles = PC3,
        inches = 0.5,
        main = "PCA Bubble Plot")

############################################################
# 3D Plot
############################################################

plot3d(scores[,1], scores[,2], scores[,3],
       xlab = "PC1", ylab = "PC2", zlab = "PC3")

############################################################
# Biplot
############################################################

pca.cor2 <- princomp(~ w1 + w2 + w4 + w5 + w6,
                     data = goblet2,
                     cor = TRUE,
                     scores = TRUE)

biplot(pca.cor2,
       main = "Biplot",
       pc.biplot = TRUE)
