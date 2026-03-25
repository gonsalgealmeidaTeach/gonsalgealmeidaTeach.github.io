############################################################
# Week 4: Regularization (LASSO for Logistic Regression)
############################################################

source("setup/install_packages.R")

library(DAAG)
library(glmnet)

data("frogs")

frogs$logNoPools  <- log(frogs$NoOfPools)
frogs$logdistance <- log(frogs$distance)

############################################################
# Prepare Data
############################################################

data_env <- frogs[, c("logdistance", "logNoPools", "NoOfSites", "avrain")]

############################################################
# Fit LASSO Model
############################################################

lasso_mod <- glmnet(
  as.matrix(data_env),
  frogs$pres.abs,
  family = "binomial"
)

plot(lasso_mod)

coef(lasso_mod)

############################################################
# Cross-Validation
############################################################

set.seed(222)

cvfit <- cv.glmnet(
  as.matrix(data_env),
  frogs$pres.abs,
  family = "binomial"
)

plot(cvfit)

cvfit$lambda.min
cvfit$lambda.1se

coef(cvfit, s = "lambda.min")

############################################################
# Interpretation
############################################################

# - LASSO performs variable selection
# - Shrinks coefficients toward zero
# - Helps prevent overfitting
