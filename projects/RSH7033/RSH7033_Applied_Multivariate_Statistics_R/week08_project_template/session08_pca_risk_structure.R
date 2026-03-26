# session08_pca_risk_structure.R

returns <- read.csv("data/portfolio_returns.csv")

pca <- prcomp(returns, scale. = TRUE)

summary(pca)

plot(pca, type = "l", main = "Scree Plot")

biplot(pca)
