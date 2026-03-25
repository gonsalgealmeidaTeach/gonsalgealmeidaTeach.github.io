############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 1: Matrix Operations for Multivariate Analysis
# Description:
# This script introduces matrix algebra concepts used in
# multivariate statistics, including matrix operations,
# inversion, and regression representation.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Create matrices (representing multivariate data)
############################################################

# Each row = observation
# Each column = variable

mat1 <- matrix(c(4, 3, 4, 5, 3, 5, 3, 22, 2, 1), ncol = 2)
mat1

mat2 <- matrix(c(5, 3, 3, 5, 3, 4, 3, 45, 77, 3), ncol = 2)
mat2

############################################################
# 2. Dimensions (N × p structure)
############################################################

nrow(mat1)  # number of observations
ncol(mat1)  # number of variables

############################################################
# 3. Matrix addition (combining variables)
############################################################

mat3 <- mat1 + mat2
mat3

############################################################
# 4. Element-wise multiplication
############################################################

mat4 <- mat1 * mat2
mat4

############################################################
# 5. Matrix multiplication (core multivariate operation)
############################################################

mat5 <- t(mat1) %*% mat2
mat5

mat6 <- mat1 %*% t(mat2)
mat6

# Interpretation:
# Matrix multiplication forms the basis of covariance,
# regression, and multivariate transformations.

############################################################
# 6. Cross-product operations
############################################################

mat7 <- crossprod(mat1, mat2)
mat7

mat8 <- tcrossprod(mat1, mat2)
mat8

############################################################
# 7. Matrix inverse
############################################################

# Check rank deficiency
nrow(mat7) - qr(mat7)$rank

# Compute inverse (if full rank)
mat7_inv <- solve(mat7)

mat7_inv %*% mat7  # should be identity
mat7 %*% mat7_inv

############################################################
# 8. Identity matrix
############################################################

I <- diag(2)
I

mat7 %*% I

############################################################
# 9. Non-invertible case
############################################################

nrow(mat8) - qr(mat8)$rank

# solve(mat8)  # will fail if singular

############################################################
# 10. Generalized inverse
############################################################

library(MASS)

ginv(mat8)

############################################################
# 11. Matrix form of multiple regression
############################################################

# Simulated dataset (students will replace later)
set.seed(123)

reg_mat <- matrix(sample(seq(1,20), 60, replace = TRUE), ncol = 4)
reg_mat

# Add intercept
inter <- rep(1, nrow(reg_mat))
X <- cbind(inter, reg_mat)

# Response variable
y <- sample(seq(1,20), 15, replace = TRUE)

############################################################
# 12. Regression using matrix algebra
############################################################

# β = (X'X)^(-1) X'Y

beta_hat <- solve(t(X) %*% X) %*% t(X) %*% y
beta_hat

############################################################
# 13. Compare with lm()
############################################################

model <- lm(y ~ ., data = data.frame(reg_mat))
coefficients(model)

############################################################
# 14. Interpretation (IMPORTANT)
############################################################

# Interpretation:
# Matrix algebra provides the foundation for multivariate
# statistical methods, including regression, PCA, and
# covariance estimation.
