############################################################
# Week 6: Multinomial Logistic Regression (Wheat Data)
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

wheat <- read.csv("data/wheat.csv")

############################################################
# Fit Model
############################################################

library(nnet)

mod.fit <- multinom(type ~ class + density + hardness + size + weight + moisture,
                    data = wheat)

summary(mod.fit)

############################################################
# Predictions
############################################################

pi_hat <- predict(mod.fit, type = "probs")
head(pi_hat)

class_pred <- predict(mod.fit, type = "class")
head(class_pred)

############################################################
# Interpretation
############################################################

# - Multinomial regression models multiple categories
# - Outputs probability for each class
