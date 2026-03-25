############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 4: Logistic Regression Diagnostics
# Description:
# This script demonstrates non-convergence and separation
# issues in logistic regression models.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Example 1: Perfect Separation
############################################################

set1 <- data.frame(
  x1 = 1:10,
  y = c(rep(0,5), rep(1,5))
)

mod.fit1 <- glm(y ~ x1,
                data = set1,
                family = binomial(link = "logit"))

summary(mod.fit1)

############################################################
# Visualization
############################################################

plot(set1$x1, set1$y,
     main = "Perfect Separation",
     xlab = expression(x[1]),
     ylab = "Observed Outcome")

curve(predict(mod.fit1,
              newdata = data.frame(x1 = x),
              type = "response"),
      col = "red", add = TRUE, lwd = 2)

############################################################
# 2. Example 2: Near Separation
############################################################

set2 <- data.frame(
  x1 = c(1,2,3,4,6,5,7,8,9,10),
  y = c(rep(0,5), rep(1,5))
)

mod.fit2 <- glm(y ~ x1,
                data = set2,
                family = binomial(link = "logit"))

summary(mod.fit2)

############################################################
# Visualization
############################################################

plot(set2$x1, set2$y,
     main = "Near Separation",
     xlab = expression(x[1]),
     ylab = "Observed Outcome")

curve(predict(mod.fit2,
              newdata = data.frame(x1 = x),
              type = "response"),
      col = "red", add = TRUE, lwd = 2)

############################################################
# Interpretation
############################################################

# - Perfect separation leads to unstable estimates
# - Model coefficients may diverge
# - Important limitation in logistic regression
