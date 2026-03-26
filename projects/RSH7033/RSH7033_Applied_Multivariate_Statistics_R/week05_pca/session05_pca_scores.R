############################################################
# Week 5: PCA Scores and Interpretation
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

cereal <- read.csv("data/cereal.csv")

cereal$sugar  <- cereal$sugar_g / cereal$size_g
cereal$fat    <- cereal$fat_g / cereal$size_g
cereal$sodium <- cereal$sodium_mg / cereal$size_g

vars <- cereal[, c("sugar", "fat", "sodium")]

############################################################
# PCA Model
############################################################

pca.save <- princomp(~ sugar + fat + sodium,
                     data = cereal,
                     cor = TRUE,
                     scores = TRUE)

############################################################
# PCA Scores
############################################################

head(pca.save$scores)
head(predict(pca.save))

############################################################
# Manual Score Calculation
############################################################

Z <- scale(vars)

z1 <- Z[1,]

pca.save$loadings[,1] %*% z1
pca.save$loadings[,2] %*% z1
pca.save$loadings[,3] %*% z1

############################################################
# Interpretation
############################################################

# Scores represent projection onto principal components
# Loadings determine contribution of each variable
