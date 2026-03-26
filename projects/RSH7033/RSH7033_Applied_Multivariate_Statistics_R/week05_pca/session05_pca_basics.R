############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 5: PCA Basics (Cereal Data)
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Load Data
############################################################

cereal <- read.csv("data/cereal.csv")

head(cereal)

############################################################
# 2. Feature Engineering
############################################################

cereal$sugar  <- cereal$sugar_g / cereal$size_g
cereal$fat    <- cereal$fat_g / cereal$size_g
cereal$sodium <- cereal$sodium_mg / cereal$size_g

vars <- cereal[, c("sugar", "fat", "sodium")]

############################################################
# 3. Correlation Matrix
############################################################

cor(vars)

############################################################
# 4. PCA Using Correlation Matrix
############################################################

pca.save <- princomp(~ sugar + fat + sodium,
                     data = cereal,
                     cor = TRUE,
                     scores = TRUE)

summary(pca.save, loadings = TRUE, cutoff = 0)

############################################################
# Interpretation
############################################################

# PCA transforms variables into uncorrelated components
# First component explains the most variance
