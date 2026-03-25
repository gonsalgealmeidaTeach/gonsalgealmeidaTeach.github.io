############################################################
# Week 4: Model Selection for Logistic Regression
############################################################

source("setup/install_packages.R")

library(DAAG)
library(MuMIn)

data("frogs")

frogs$logNoPools  <- log(frogs$NoOfPools)
frogs$logdistance <- log(frogs$distance)

############################################################
# Base Model
############################################################

frog.glm <- glm(
  pres.abs ~ logdistance + logNoPools +
  NoOfSites + avrain +
  altitude + meanmax + meanmin,
  family = binomial,
  data = frogs
)

############################################################
# Model Selection (AIC)
############################################################

models <- dredge(frog.glm)

models

############################################################
# Candidate Models
############################################################

cand_models <- get.models(models, subset = delta < 3)

summary(model.avg(cand_models))

############################################################
# Stepwise Selection
############################################################

null_model <- glm(pres.abs ~ 1,
                  family = binomial,
                  data = frogs)

step(frog.glm,
     direction = "both",
     scope = list(upper = frog.glm, lower = null_model))

############################################################
# Interpretation
############################################################

# - AIC selects parsimonious models
# - Stepwise explores model space automatically
