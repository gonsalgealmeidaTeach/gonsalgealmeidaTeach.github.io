
############################################################
# DistanceExample.R
# Demonstration of Euclidean Distance Calculation
# and Visualization of Pairwise Distances
############################################################

# Simple distance example
x1 <- c(2, 3.4)
x2 <- c(4, 5)

# Euclidean distance
sqrt(t(x1 - x2) %*% (x1 - x2))

############################################################
# Create small dataset
set1 <- data.frame(
  var1 = c(2, 4, 6, 4),
  var2 = c(3.4, 5, 3, 2)
)

############################################################
# Distance matrix
dist.mat <- dist(set1, method = "euclidean")
dist.mat

# Convert to matrix for indexing
dist.mat <- as.matrix(dist.mat)
dist.mat

# Access a specific distance
dist.mat[1,2]

# Show full symmetric matrix
dist(set1, method = "euclidean", upper = TRUE)

############################################################
# Visualization of distances

par(pty = "s")

plot(
  x = set1$var1,
  y = set1$var2,
  xlab = "Variable 1",
  ylab = "Variable 2",
  pch = 16,
  col = "blue",
  cex = 2,
  xlim = c(0,7),
  ylim = c(0,7)
)

grid()

# Draw distance segments
for(i in 1:3){
  for(j in (i+1):4){

    segments(
      set1$var1[i], set1$var2[i],
      set1$var1[j], set1$var2[j],
      col = "red"
    )

    text(
      (set1$var1[i]+set1$var1[j])/2,
      (set1$var2[i]+set1$var2[j])/2,
      labels = round(dist.mat[i,j],2)
    )
  }
}

text(set1$var1, set1$var2, labels = 1:4, col = "white")

############################################################
# Alternative distance calculation using cluster package

library(cluster)
daisy(set1, metric = "euclidean")
