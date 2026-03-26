############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 7: Hierarchical Clustering – Linkage Methods
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Create Dataset
############################################################

set1 <- data.frame(
  var1 = c(2,4,6,4),
  var2 = c(3.4,5,3,2)
)

set1

############################################################
# 2. Distance Matrix
############################################################

dist.mat <- dist(set1, method = "euclidean")

dist.mat

############################################################
# 3. Single Linkage
############################################################

clust.single <- hclust(dist.mat, method = "single")

plot(clust.single,
     main = "Single Linkage Clustering")

############################################################
# 4. Complete Linkage
############################################################

clust.complete <- hclust(dist.mat, method = "complete")

plot(clust.complete,
     main = "Complete Linkage Clustering")

############################################################
# 5. Centroid Linkage
############################################################

# Note: centroid uses squared distances
clust.centroid <- hclust(dist.mat^2, method = "centroid")

plot(clust.centroid,
     main = "Centroid Linkage Clustering")

############################################################
# 6. Average Linkage
############################################################

clust.average <- hclust(dist.mat, method = "average")

plot(clust.average,
     main = "Average Linkage Clustering")

############################################################
# 7. Ward Method
############################################################

clust.ward <- hclust(dist.mat, method = "ward.D")

plot(clust.ward,
     main = "Ward Clustering")

############################################################
# Interpretation
############################################################

# Different linkage methods define distance between clusters differently:
# - Single: nearest points
# - Complete: farthest points
# - Average: average distance
# - Centroid: cluster centers
# - Ward: minimizes within-cluster variance
