############################################################
# Week 6: Linear Discriminant Analysis (LDA)
############################################################

source("setup/install_packages.R")

library(MASS)

############################################################
# Load Data
############################################################

placekick <- read.csv("data/placekick.csv")

############################################################
# Fit LDA Model
############################################################

lda_fit <- lda(good ~ week + distance + change +
               elap30 + PAT + type + field + wind,
               data = placekick)

lda_fit

############################################################
# Predictions
############################################################

pred <- predict(lda_fit)

head(pred$class)
head(pred$posterior)
