############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 7: K-Means Clustering
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Load Data
############################################################

data(iris)

X <- iris[,1:4]

############################################################
# 2. Standardize Data
############################################################

Z <- scale(X)

############################################################
# 3. Apply K-Means (k = 3)
############################################################

set.seed(123)

kmeans_fit <- kmeans(Z, centers = 3, nstart = 25)

kmeans_fit

############################################################
# 4. Cluster Assignments
############################################################

clusters <- kmeans_fit$cluster

table(clusters)

############################################################
# 5. Compare with True Labels
############################################################

table(iris$Species, clusters)

############################################################
# 6. Visualization (First Two Variables)
############################################################

plot(Z[,1], Z[,2],
     col = clusters,
     pch = 19,
     xlab = "Feature 1",
     ylab = "Feature 2",
     main = "K-Means Clustering")

points(kmeans_fit$centers[,1],
       kmeans_fit$centers[,2],
       col = 1:3,
       pch = 8,
       cex = 2)

############################################################
# Interpretation
############################################################

# K-means partitions data into k clusters
# Minimizes within-cluster variance
# Sensitive to initialization → use nstart
