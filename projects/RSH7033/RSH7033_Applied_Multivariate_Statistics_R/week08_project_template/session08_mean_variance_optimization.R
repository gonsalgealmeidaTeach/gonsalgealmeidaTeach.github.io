############################################################
# Week 8: Mean-Variance Portfolio Optimization
############################################################

source("setup/install_packages.R")

library(quadprog)

############################################################
# 1. Load Data (example: use your own stock data)
############################################################

# Example structure: rows = time, cols = assets
# Replace with your dataset
returns <- read.csv("data/portfolio_returns.csv")

returns <- as.matrix(returns)

############################################################
# 2. Compute Mean and Covariance
############################################################

mu <- colMeans(returns)
Sigma <- cov(returns)

############################################################
# 3. Optimization Setup
############################################################

n <- length(mu)

Dmat <- 2 * Sigma
dvec <- rep(0, n)

# Constraints:
# Sum of weights = 1
# No short selling (w >= 0)

Amat <- cbind(rep(1, n), diag(n))
bvec <- c(1, rep(0, n))

############################################################
# 4. Solve Optimization Problem
############################################################

result <- solve.QP(Dmat, dvec, Amat, bvec, meq = 1)

weights <- result$solution

weights

############################################################
# 5. Portfolio Performance
############################################################

portfolio_return <- sum(weights * mu)
portfolio_risk   <- sqrt(t(weights) %*% Sigma %*% weights)

portfolio_return
portfolio_risk

############################################################
# Interpretation
############################################################

# Optimal weights minimize variance subject to constraints
# This is the foundation of modern portfolio theory
