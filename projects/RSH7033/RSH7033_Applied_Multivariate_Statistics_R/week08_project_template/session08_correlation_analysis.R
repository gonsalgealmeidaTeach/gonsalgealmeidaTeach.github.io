# session08_correlation_analysis.R

returns <- read.csv("data/portfolio_returns.csv")

cor_mat <- cor(returns)

cor_mat

heatmap(cor_mat, main = "Correlation Matrix")
