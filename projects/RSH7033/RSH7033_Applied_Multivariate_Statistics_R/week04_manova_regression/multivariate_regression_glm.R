############################################################
# RSH7033 – Applied Multivariate Statistics
# Trine University
#
# Week 4 – Multivariate Regression and Generalized Linear Models
#
# Script: multivariate_regression_glm.R
#
# Instructor: Dr. Gonsalge Almeida
#
# Objectives
# 1. Understand generalized linear models (GLMs)
# 2. Fit logistic regression models in R
# 3. Diagnose model assumptions
# 4. Perform model selection
############################################################

############################################################
# Load Required Packages
############################################################

library(DAAG)       # dataset
library(car)        # diagnostics and VIF
library(MuMIn)      # model selection
library(glmnet)     # LASSO
library(shrink)     # shrinkage methods
library(statmod)    # residual diagnostics
library(faraway)    # logistic functions

############################################################
# Example Dataset
############################################################

# Dataset describing environmental variables
# influencing presence/absence of the
# Southern Corroboree frog

data("frogs")

# Inspect dataset
str(frogs)
summary(frogs)

############################################################
# Initial Linear Model (for demonstration)
############################################################

# Linear regression is inappropriate for a binary response
# but helps illustrate assumption violations

flaw_mod <- lm(pres.abs ~ distance, data = frogs)

summary(flaw_mod)

par(mfrow = c(2,2))
plot(flaw_mod)

############################################################
# Examine Distributions of Variables
############################################################

# Scatterplot matrix of environmental predictors

spm(frogs[,c(4:10)])

# Examine ranges of variables

summary(frogs$distance)
summary(frogs$NoOfPools)
summary(frogs$NoOfSites)

############################################################
# Transformation of Skewed Variables
############################################################

par(mfrow=c(2,3))

for(nam in c("distance","NoOfPools")){

  y <- frogs[,nam]

  plot(density(y), main=paste("Original:",nam))
  plot(density(sqrt(y)), main=paste("Sqrt:",nam))
  plot(density(log(y)), main=paste("Log:",nam))

}

# Log transformation selected

frogs$logNoPools  <- log(frogs$NoOfPools)
frogs$logdistance <- log(frogs$distance)

############################################################
# Multicollinearity Check
############################################################

spm(frogs[,c(4,7:12)])

cor(frogs[,c(4,7:12)])

############################################################
# Fit Logistic Regression Model (GLM)
############################################################

frog.glm <- glm(
  pres.abs ~ logdistance + logNoPools +
  NoOfSites + avrain +
  altitude + meanmax + meanmin,
  family = binomial(link="logit"),
  data = frogs
)

summary(frog.glm)

# Variance Inflation Factor
vif(frog.glm)

############################################################
# Reduced Model to Address Collinearity
############################################################

frog.glm2 <- glm(
  pres.abs ~ logdistance + logNoPools +
  NoOfSites + avrain +
  I(meanmax + meanmin),
  family = binomial,
  data = frogs
)

vif(frog.glm2)

############################################################
# Model Selection using Information Criteria
############################################################

models <- dredge(frog.glm2)

models

# Candidate models within ΔAIC < 3

cand_models <- get.models(models, subset = delta < 3)

summary(model.avg(cand_models))

############################################################
# Backward Selection (Likelihood Ratio Test)
############################################################

frog.glm3 <- update(frog.glm2, ~ . - NoOfSites)

summary(frog.glm3)

anova(frog.glm3, frog.glm2, test="Chisq")

############################################################
# Automatic Stepwise Selection
############################################################

null_model <- glm(pres.abs ~ 1,
                  family = binomial,
                  data = frogs)

n <- length(frogs$pres.abs)

step(frog.glm2,
     direction="both",
     scope=list(upper=frog.glm2, lower=null_model),
     k=log(n))

############################################################
# LASSO Regularization
############################################################

data_env <- frogs[,names(frogs) %in% c(
  "logdistance",
  "logNoPools",
  "NoOfSites",
  "avrain"
)]

data_env$meanmaxmin <- frogs$meanmin + frogs$meanmax

lasso_mod <- glmnet(
  as.matrix(data_env),
  frogs$pres.abs,
  family="binomial"
)

plot(lasso_mod)

coef(lasso_mod)

############################################################
# Cross Validation for Optimal Lambda
############################################################

set.seed(222)

cvfit <- cv.glmnet(
  as.matrix(data_env),
  frogs$pres.abs,
  family="binomial"
)

plot(cvfit)

cvfit$lambda.min
cvfit$lambda.1se

coef(cvfit, s="lambda.min")
coef(cvfit, s="lambda.1se")

############################################################
# Model Diagnostics
############################################################

summary(frog.glm3)

# Dispersion parameter

frog.glm3$deviance / frog.glm3$df.resid

############################################################
# Residual Diagnostics
############################################################

qr <- qres.binom(frog.glm3)

qqnorm(qr)
qqline(qr)

residualPlots(frog.glm3)

crPlots(frog.glm3)

############################################################
# Influential Observations
############################################################

influenceIndexPlot(frog.glm3,
                   vars=c("Cook","hat"),
                   id.n=3)

influencePlot(frog.glm3)

############################################################
# Interpreting Logistic Model Output
############################################################

par(mfrow=c(2,2))

termplot(frog.glm3)

# Convert log-odds to probability

ilogit(-2)
ilogit(4)

############################################################
# Cross Validation Accuracy
############################################################

CVbinary(frog.glm3, nfolds=10)

############################################################
# End of Script
############################################################
