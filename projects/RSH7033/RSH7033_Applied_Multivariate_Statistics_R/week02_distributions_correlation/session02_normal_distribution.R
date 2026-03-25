############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 2: Multivariate Normal Distribution
# Description:
# Visualization and interpretation of univariate and
# multivariate normal distributions, including covariance
# structure and geometric interpretation.
############################################################

# Load setup
source("setup/install_packages.R")

# Set seed for reproducibility
set.seed(123)

############################################################
# 1. Univariate Normal Distribution
############################################################

curve(dnorm(x, mean = 50, sd = 3),
      xlim = c(40, 60),
      col = "red",
      main = "Univariate Normal Distribution",
      xlab = "x", ylab = "Density")

# Interpretation:
# - Peak occurs at the mean (50)
# - Spread determined by standard deviation (3)

############################################################
# 2. Multivariate Normal Setup
############################################################

mu <- c(15, 20)

sigma <- matrix(c(1, 0.5,
                  0.5, 1.25),
                nrow = 2)

# Convert covariance to correlation
cor_matrix <- cov2cor(sigma)
cor_matrix

# Interpretation:
# - Positive correlation → variables increase together
# - Correlation affects the shape of contours

############################################################
# 3. Density Evaluation
############################################################

library(mvtnorm)

dmvnorm(x = mu, mean = mu, sigma = sigma)

# Interpretation:
# - Maximum density occurs at the mean vector
# - Density decreases as distance from the mean increases

############################################################
# 4. Contour Plot (Geometric Interpretation)
############################################################

x1 <- seq(10, 25, by = 0.1)
x2 <- seq(10, 25, by = 0.1)

grid <- expand.grid(x1, x2)

z <- dmvnorm(grid, mean = mu, sigma = sigma)

z_matrix <- matrix(z, nrow = length(x1))

contour(x1, x2, z_matrix,
        main = "Multivariate Normal Contours",
        xlab = expression(x[1]),
        ylab = expression(x[2]))

# Interpretation:
# - Elliptical contours represent equal density levels
# - Shape determined by covariance matrix
# - Tilt of ellipse indicates correlation between variables

############################################################
# 5. Connection to Course Concepts
############################################################

# This structure forms the basis for:
# - Multivariate outlier detection
# - Mahalanobis distance
# - Principal Components Analysis (Week 5)
# - Multivariate regression modeling
