############################################################
# Week 7: Cluster Validation
############################################################

# Load setup
source("setup/install_packages.R")

library(cluster)

############################################################
# 1. Load Data
############################################################

data(iris)

X <- iris[,1:4]

Z <- scale(X)

############################################################
# 2. K-Means Model
############################################################

set.seed(123)

kmeans_fit <- kmeans(Z, centers = 3, nstart = 25)

clusters <- kmeans_fit$cluster

############################################################
# 3. Within-Cluster Sum of Squares (WSS)
############################################################

kmeans_fit$tot.withinss

############################################################
# 4. Elbow Method
############################################################

wss <- numeric(10)

for(k in 1:10){
  kfit <- kmeans(Z, centers = k, nstart = 10)
  wss[k] <- kfit$tot.withinss
}

plot(1:10, wss,
     type = "b",
     xlab = "Number of Clusters (k)",
     ylab = "Within-Cluster Sum of Squares",
     main = "Elbow Method")

############################################################
# 5. Silhouette Analysis
############################################################

sil <- silhouette(clusters, dist(Z))

plot(sil,
     main = "Silhouette Plot")

mean(sil[,3])

############################################################
# 6. Interpretation
############################################################

# WSS decreases as k increases
# Elbow point suggests optimal k
# Silhouette measures cluster separation
# Higher silhouette → better clustering
