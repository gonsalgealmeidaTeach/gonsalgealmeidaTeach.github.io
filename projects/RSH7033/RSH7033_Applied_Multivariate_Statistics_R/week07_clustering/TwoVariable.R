
############################################################
# TwoVariable.R
# Hierarchical Clustering Demonstration
############################################################

set1 <- data.frame(
  var1 = c(2,4,6,4),
  var2 = c(3.4,5,3,2)
)

############################################################
# Distance matrix
dist.mat <- dist(set1, method = "euclidean")

############################################################
# Single linkage clustering
clust.single <- hclust(dist.mat, method = "single")
clust.single$merge
plot(clust.single, main = "Single Linkage Clustering")

############################################################
# Complete linkage clustering
clust.complete <- hclust(dist.mat, method = "complete")
clust.complete$merge
plot(clust.complete, main = "Complete Linkage Clustering")

############################################################
# Centroid linkage clustering
clust.centroid <- hclust(dist.mat^2, method = "centroid")
clust.centroid$merge
plot(clust.centroid, main = "Centroid Linkage Clustering")

############################################################
# Average linkage clustering
clust.average <- hclust(dist.mat, method = "average")
clust.average$merge
plot(clust.average, main = "Average Linkage Clustering")

############################################################
# Ward method
clust.ward <- hclust(dist.mat, method = "ward.D")
clust.ward$merge
plot(clust.ward, main = "Ward Clustering")
