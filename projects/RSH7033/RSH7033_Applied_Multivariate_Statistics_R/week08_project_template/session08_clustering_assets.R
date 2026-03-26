# session08_clustering_assets.R

returns <- read.csv("data/portfolio_returns.csv")

dist_mat <- dist(t(returns))

hc <- hclust(dist_mat)

plot(hc, main = "Asset Clustering")
