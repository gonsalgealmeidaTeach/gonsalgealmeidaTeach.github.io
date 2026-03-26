# session08_regression_modeling.R

returns <- read.csv("data/portfolio_returns.csv")

# Example: predict asset 1 using others
model <- lm(returns[,1] ~ ., data = returns)

summary(model)
