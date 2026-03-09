################################################################################
# RSH7033 – Applied Multivariate Statistics with R
# Week 05: Advanced PCA Interpretation
#
# Instructor: Dr. Gonsalge Almeida
################################################################################


############################################################
# Define Data Path
############################################################

# All datasets are stored in the repository data folder

data_path <- "../data/"


############################################################
# Load Required Packages
############################################################

packages <- c(
  "vegan",
  "chemometrics",
  "pcaPP"
)

installed <- packages %in% rownames(installed.packages())

if(any(installed == FALSE)){
  install.packages(packages[!installed])
}

lapply(packages, library, character.only = TRUE)



############################################################
# Load Example Dataset
############################################################

# Soil chemistry data used for PCA demonstration

data(varechem)

head(varechem)



############################################################
# Perform PCA
############################################################

# Standardize variables before PCA

pca_model <- rda(varechem, scale = TRUE)

summary(pca_model)



############################################################
# PCA Scree Plot
############################################################

# Scree plot shows variance explained by each PC

screeplot(pca_model, type = "lines")



############################################################
# PCA Biplot
############################################################

# Shows both sites and variables

biplot(
  pca_model,
  scaling = 3,
  display = c("sites","species")
)



############################################################
# Extract PCA Scores
############################################################

# PCA scores represent observations in reduced space

pca_scores <- scores(
  pca_model,
  display = "sites"
)

head(pca_scores)



############################################################
# Extract Variable Loadings
############################################################

# Loadings represent contribution of variables

loadings <- pca_model$CA$v

loadings



############################################################
# Correlation between Variables and PCA Axes
############################################################

cor(scale(varechem), pca_scores)



############################################################
# Sparse PCA
############################################################

# Sparse PCA simplifies interpretation by reducing
# number of variables contributing to each component

k.max <- 2

sparse_model <- sPCAgrid(
  scale(varechem),
  k = k.max
)

biplot(sparse_model)



############################################################
# Compare PCA and Sparse PCA
############################################################

# Compare variable loadings

sparse_model$loadings



############################################################
# PCA Scores for Further Analysis
############################################################

# PCA scores can be used for:
# - regression models
# - clustering
# - classification

pca_scores[,1:4]



############################################################
# Example Exercise Dataset
############################################################

# Glass composition dataset

data(glass)

head(glass)



############################################################
# Student Exercise
############################################################

# 1. Perform PCA on glass dataset
# 2. Determine number of meaningful components
# 3. Create scree plot
# 4. Interpret variable loadings
# 5. Compare with sparse PCA
