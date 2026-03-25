############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 2: Multivariate Normal Distribution
# Description:
# Visualization and interpretation of univariate and
# multivariate normal distributions.
############################################################

source("setup/install_packages.R")

############################################################
# 1. Univariate Normal Distribution
############################################################

curve(dnorm(x, mean = 50, sd = 3),
      xlim = c(40, 60),
      col = "red",
      main = "Univariate Normal Distribution")

# Interpretation:
# Peak at mean (50), spread controlled by standard deviation

############################################################
# 2. Multivariate Normal Setup
############################################################

library(mvtnorm)

mu <- c(15, 20)
sigma <- matrix(c(1, 0.5, 0.5, 1.25), nrow = 2)

cov2cor(sigma)

############################################################
# 3. Density Evaluation
############################################################

dmvnorm(x = mu, mean = mu, sigma = sigma)

# Interpretation:
# Highest density occurs at the mean vector

############################################################
# 4. Contour Plot
############################################################

x1 <- seq(10, 25, by = 0.1)
x2 <- seq(10, 25, by = 0.1)

grid <- expand.grid(x1, x2)
z <- dmvnorm(grid, mean = mu, sigma = sigma)

z_matrix <- matrix(z, nrow = length(x1))

contour(x1, x2, z_matrix,
        main = "Multivariate Normal Contours")

# Interpretation:
# Elliptical shapes reflect covariance structure
