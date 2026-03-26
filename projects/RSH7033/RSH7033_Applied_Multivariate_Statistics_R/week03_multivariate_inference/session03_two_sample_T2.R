############################################################
# Week 3: Two-Sample Hotelling's T² Test
############################################################

source("setup/install_packages.R")

library(ICSNP)

############################################################
# Load Data
############################################################

data(iris)

group1 <- subset(iris, Species == "setosa")[,1:4]
group2 <- subset(iris, Species == "versicolor")[,1:4]

############################################################
# Two-Sample Test
############################################################

hotelling.test(group1, group2)

############################################################
# Interpretation
############################################################

# Tests equality of mean vectors between two groups
