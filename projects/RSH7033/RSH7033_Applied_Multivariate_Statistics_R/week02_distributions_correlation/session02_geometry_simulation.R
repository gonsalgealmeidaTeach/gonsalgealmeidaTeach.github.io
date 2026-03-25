############################################################
# Week 2: Geometry and Simulation
############################################################

source("setup/install_packages.R")

library(mvtnorm)
library(MASS)

############################################################
# 1. Simulate Multivariate Data
############################################################

set.seed(123)

mu <- c(15, 20)
sigma <- matrix(c(1, 0.5, 0.5, 1.25), nrow = 2)

x <- rmvnorm(50, mean = mu, sigma = sigma)

############################################################
# 2. Sample Estimates
############################################################

colMeans(x)
cov(x)
cor(x)

############################################################
# 3. Density Estimation
############################################################

kde <- kde2d(x[,1], x[,2])

contour(kde, main = "Estimated Density")

############################################################
# 4. Eigenvectors
############################################################

eig <- eigen(sigma)

eig$values
eig$vectors

# Interpretation:
# Eigenvectors = direction of spread
# Eigenvalues = magnitude of spread
