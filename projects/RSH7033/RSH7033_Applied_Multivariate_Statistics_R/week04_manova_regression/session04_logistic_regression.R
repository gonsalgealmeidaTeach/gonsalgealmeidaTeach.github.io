############################################################
# Week 4: Logistic Regression Model (Placekicking Data)
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")
valid <- read.csv("data/valid.csv")

############################################################
# Fit Logistic Regression Model
############################################################

mod.fit <- glm(good ~ week + distance + change + elap30 + PAT + type + field + wind,
               data = placekick,
               family = binomial(link = "logit"))

summary(mod.fit)

############################################################
# Predicted Probabilities
############################################################

pi_hat <- predict(mod.fit, type = "response")
head(pi_hat)

pi_hat_valid <- predict(mod.fit, newdata = valid, type = "response")
head(pi_hat_valid)

############################################################
# Interpretation
############################################################

# - Logistic regression models probability of success
# - Coefficients show effect of predictors on log-odds
