############################################################
# Week 5: Goblet PCA (Core Analysis)
############################################################

source("setup/install_packages.R")

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

vars <- goblet2[,-1]

############################################################
# Mean Vector
############################################################

mu.hat <- colMeans(vars)
mu.hat

############################################################
# PCA (Covariance Matrix)
############################################################

pca.cov <- princomp(~ w1 + w2 + w4 + w5 + w6,
                    data = goblet2,
                    cor = FALSE)

summary(pca.cov, loadings = TRUE, cutoff = 0)

############################################################
# Check Orthogonality
############################################################

sum(pca.cov$loadings[,1] * pca.cov$loadings[,2])
sqrt(sum(pca.cov$loadings[,1]^2))

############################################################
# PCA Scores
############################################################

scores <- pca.cov$scores
head(scores)

############################################################
# Prediction for New Observation
############################################################

pred.set <- data.frame(
  w1 = 0.5652174,
  w2 = 0.9130435,
  w4 = 0.6086957,
  w5 = 0.3043478,
  w6 = 0.3478261
)

predict(pca.cov, newdata = pred.set)

############################################################
# Scree Plot
############################################################

plot(pca.cov,
     type = "lines",
     main = "Scree Plot")
