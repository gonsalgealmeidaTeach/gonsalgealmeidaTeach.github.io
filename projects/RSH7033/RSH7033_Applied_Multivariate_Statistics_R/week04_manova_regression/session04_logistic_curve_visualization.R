############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 4: Logistic Regression Visualization
# Description:
# This script visualizes logistic regression probability
# curves and illustrates the effect of model coefficients.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Basic Curve Example
############################################################

curve(x^2,
      xlim = c(-1, 2),
      col = "red",
      main = "Example: f(x) = x^2",
      xlab = "x",
      ylab = "f(x)")

############################################################
# 2. Logistic Regression Curves
############################################################

par(mfrow = c(1,2))

# Positive slope
beta0 <- 1
beta1 <- 0.5

curve(exp(beta0 + beta1*x) / (1 + exp(beta0 + beta1*x)),
      xlim = c(-15, 15),
      col = "black",
      main = expression(beta[1] == 0.5),
      xlab = expression(x[1]),
      ylab = expression(pi))

# Negative slope
beta1 <- -0.5

curve(exp(beta0 + beta1*x) / (1 + exp(beta0 + beta1*x)),
      xlim = c(-15, 15),
      col = "black",
      main = expression(beta[1] == -0.5),
      xlab = expression(x[1]),
      ylab = expression(pi))

############################################################
# 3. Interpretation
############################################################

# Interpretation:
# - Logistic regression models probabilities between 0 and 1
# - Positive slope → increasing probability with x
# - Negative slope → decreasing probability with x
# - Curve shape is S-shaped (sigmoid)
