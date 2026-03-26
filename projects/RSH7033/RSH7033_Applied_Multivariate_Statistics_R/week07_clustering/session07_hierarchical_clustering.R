############################################################
# Week 7: Hierarchical Clustering (Goblet Data)
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

goblet <- read.csv("data/goblet.csv")

goblet2 <- data.frame(
  ID = goblet$goblet,
  w1 = goblet$x1 / goblet$x3,
  w2 = goblet$x2 / goblet$x3,
  w4 = goblet$x4 / goblet$x3,
  w5 = goblet$x5 / goblet$x3,
  w6 = goblet$x6 / goblet$x3
)

vars <- goblet2[,-1]

############################################################
# Distance Matrix
############################################################

dist.mat <- dist(vars, method = "euclidean")

############################################################
# Hierarchical Clustering
############################################################

hc <- hclust(dist.mat, method = "complete")

############################################################
# Dendrogram
############################################################

plot(hc,
     main = "Hierarchical Clustering (Goblet Data)",
     xlab = "",
     sub = "")

############################################################
# Cut Tree into Clusters
############################################################

clusters <- cutree(hc, k = 3)

clusters

############################################################
# Add cluster labels
############################################################

goblet2$cluster <- clusters

head(goblet2)

############################################################
# Interpretation
############################################################

# Hierarchical clustering builds nested clusters
# Dendrogram shows merging structure
# cutree defines number of clusters
