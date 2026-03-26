############################################################
# Week 5: PCA Methods and Scree Plot
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
# Scree Plot
############################################################

pca.save <- princomp(~ sugar + fat + sodium,
                     data = cereal,
                     cor = TRUE)

plot(pca.save,
     type = "lines",
     main = "Scree Plot")

############################################################
# PCA Using Covariance Matrix
############################################################

pca.cov <- princomp(~ sugar + fat + sodium,
                    data = cereal,
                    cor = FALSE)

summary(pca.cov, loadings = TRUE, cutoff = 0)

############################################################
# PCA Using prcomp()
############################################################

pca.cov2 <- prcomp(~ sugar + fat + sodium,
                   data = cereal,
                   scale. = FALSE)

summary(pca.cov2)

############################################################
# Interpretation
############################################################

# Scree plot helps choose the number of components
# Correlation-based PCA standardizes variables
# prcomp() uses SVD and is numerically stable
