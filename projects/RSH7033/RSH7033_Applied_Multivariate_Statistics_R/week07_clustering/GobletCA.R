
############################################################
# GobletCA.R
# K-Means Clustering Demonstration
############################################################

set1 <- data.frame(
  var1 = c(2,4,6,4),
  var2 = c(3.4,5,3,2)
)

############################################################
# Run K-means clustering

set.seed(7812)
clust.2means <- kmeans(set1, centers = 2)

clust.2means

############################################################
# Cluster membership
clust.2means$cluster

############################################################
# Combine clusters with dataset
set1.clust <- data.frame(set1, cluster = clust.2means$cluster)
set1.clust

############################################################
# Cluster centers
clust.2means$centers

############################################################
# Plot clusters

plot(
  set1$var1,
  set1$var2,
  pch = 16,
  col = clust.2means$cluster,
  xlab = "Variable 1",
  ylab = "Variable 2",
  main = "K-Means Clustering"
)

points(
  clust.2means$centers[,1],
  clust.2means$centers[,2],
  pch = 4,
  col = "black",
  cex = 2,
  lwd = 3
)

############################################################
# Sum of squares

clust.2means$totss
clust.2means$withinss
clust.2means$tot.withinss
clust.2means$betweenss

############################################################
# Cluster sizes
clust.2means$size

############################################################
# Different initialization example
set.seed(7813)
kmeans(set1, centers = 2)
