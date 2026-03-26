############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 7: Distance Measures for Clustering
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Simple Euclidean Distance Example
############################################################

x1 <- c(2, 3.4)
x2 <- c(4, 5)

# Manual Euclidean distance
sqrt(t(x1 - x2) %*% (x1 - x2))

############################################################
# 2. Create Dataset
############################################################

set1 <- data.frame(
  var1 = c(2, 4, 6, 4),
  var2 = c(3.4, 5, 3, 2)
)

set1

############################################################
# 3. Distance Matrix
############################################################

dist.mat <- dist(set1, method = "euclidean")
dist.mat

# Convert to matrix
dist.mat <- as.matrix(dist.mat)
dist.mat

# Example distance
dist.mat[1,2]

############################################################
# 4. Visualization of Distances
############################################################

par(pty = "s")

plot(set1$var1, set1$var2,
     xlab = "Variable 1",
     ylab = "Variable 2",
     pch = 16,
     col = "blue",
     cex = 2,
     xlim = c(0,7),
     ylim = c(0,7))

grid()

# Draw distance segments
for(i in 1:3){
  for(j in (i+1):4){

    segments(set1$var1[i], set1$var2[i],
             set1$var1[j], set1$var2[j],
             col = "red")

    text((set1$var1[i]+set1$var1[j])/2,
         (set1$var2[i]+set1$var2[j])/2,
         labels = round(dist.mat[i,j],2))
  }
}

text(set1$var1, set1$var2,
     labels = 1:4,
     col = "white")

############################################################
# 5. Alternative Distance (cluster package)
############################################################

library(cluster)

daisy(set1, metric = "euclidean")

############################################################
# Interpretation
############################################################

# Distance measures similarity between observations
# Smaller distance → more similar
# Foundation for clustering algorithms
