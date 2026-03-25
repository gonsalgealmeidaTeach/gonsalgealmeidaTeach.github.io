############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 6: Multinomial Logistic Regression Visualization
# Description:
# This script visualizes class probabilities in a multinomial
# logistic regression model as a function of a predictor.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Model Coefficients
############################################################

beta20 <- 29.20
beta21 <- -24.42

beta30 <- 18.84
beta31 <- -15.24

############################################################
# 2. Plot Class Probabilities
############################################################

curve(1 / (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x)),
      col = "black", lwd = 2,
      xlim = c(0.5, 1.75),
      ylab = expression(pi[j]),
      xlab = "x",
      main = "Multinomial Logistic Model")

curve(exp(beta20 + beta21*x) /
      (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x)),
      col = "green", lwd = 2, add = TRUE)

curve(exp(beta30 + beta31*x) /
      (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x)),
      col = "red", lwd = 2, add = TRUE)

legend("topright",
       legend = c("Class 1", "Class 2", "Class 3"),
       col = c("black", "green", "red"),
       lwd = 2,
       bty = "n")

############################################################
# 3. Compute Probabilities at Selected Points
############################################################

x <- c(seq(1.12, 1.13, by = 0.001),
       seq(1.23, 1.24, by = 0.001))

pop1 <- 1 / (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x))
pop2 <- exp(beta20 + beta21*x) /
        (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x))
pop3 <- exp(beta30 + beta31*x) /
        (1 + exp(beta20 + beta21*x) + exp(beta30 + beta31*x))

results <- data.frame(x, pop1, pop2, pop3)
results

############################################################
# 4. Interpretation
############################################################

# Interpretation:
# - Each curve represents the probability of a class
# - Probabilities sum to 1 for each x
# - Model shows how class membership changes with the predictor
