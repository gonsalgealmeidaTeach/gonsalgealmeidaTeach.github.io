############################################################
# Week 3: Confidence Regions for Mean Vector
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

data(iris)

X <- iris[,1:2]

############################################################
# Mean and Covariance
############################################################

mu <- colMeans(X)
S  <- cov(X)
n  <- nrow(X)

############################################################
# Plot Elliptical Confidence Region
############################################################

library(ellipse)

ell <- ellipse(S / n, centre = mu, level = 0.95)

plot(X,
     main = "Confidence Ellipse")

lines(ell, col = "red", lwd = 2)

points(mu[1], mu[2], col = "blue", pch = 19)

############################################################
# Interpretation
############################################################

# Confidence region accounts for covariance structure
