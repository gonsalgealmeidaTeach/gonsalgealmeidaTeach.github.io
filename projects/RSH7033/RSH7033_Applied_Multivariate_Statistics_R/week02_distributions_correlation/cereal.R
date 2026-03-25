############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 2: Multivariate Distribution and Correlation Analysis
# Dataset: cereal.csv (located in /data folder)
# Description:
# This script performs exploratory multivariate analysis,
# including mean vector, covariance, correlation, and
# standardization.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Load Data
############################################################

cereal <- read.csv("data/cereal.csv")

head(cereal)
str(cereal)

############################################################
# 2. Feature Engineering (Standardizing by serving size)
############################################################

cereal$sugar <- cereal$sugar_g / cereal$size_g
cereal$fat <- cereal$fat_g / cereal$size_g
cereal$sodium <- cereal$sodium_mg / cereal$size_g

head(cereal)

############################################################
# 3. Select Variables for Analysis
############################################################

vars <- cereal[, c("sugar", "fat", "sodium")]

############################################################
# 4. Mean Vector
############################################################

mu_hat <- colMeans(vars)
mu_hat

############################################################
# 5. Covariance Matrix
############################################################

sigma_hat <- cov(vars)
sigma_hat

############################################################
# 6. Correlation Matrix
############################################################

R <- cor(vars)
R

# Alternative
cov2cor(sigma_hat)

############################################################
# 7. Matrix Formulation (Advanced – for understanding)
############################################################

X <- as.matrix(vars)
N <- nrow(X)

X_centered <- t(t(X) - mu_hat)

cov_matrix_manual <- t(X_centered) %*% X_centered / (N - 1)
cov_matrix_manual

############################################################
# 8. Standardization
############################################################

Z <- scale(vars)

head(Z)
cov(Z)
cor(Z)
colMeans(Z)

############################################################
# 9. Validation (Example for sugar)
############################################################

z_sugar <- (vars$sugar - mean(vars$sugar)) / sd(vars$sugar)

mean(z_sugar)
sd(z_sugar)

############################################################
# 10. Interpretation (CRITICAL FOR STUDENTS)
############################################################

# Interpretation:
# - Mean vector summarizes central tendency of variables
# - Covariance shows direction and magnitude of relationships
# - Correlation standardizes relationships for comparison
# - Standardization removes scale differences between variables
