############################################################
# Week 7: Goblet Data Preprocessing
############################################################

source("setup/install_packages.R")

############################################################
# Load Data
############################################################

goblet <- read.csv("data/goblet.csv")

############################################################
# Feature Engineering (Ratios)
############################################################

goblet2 <- data.frame(
  ID = goblet$goblet,
  w1 = goblet$x1 / goblet$x3,
  w2 = goblet$x2 / goblet$x3,
  w4 = goblet$x4 / goblet$x3,
  w5 = goblet$x5 / goblet$x3,
  w6 = goblet$x6 / goblet$x3
)

head(goblet2)

############################################################
# Remove ID for clustering
############################################################

vars <- goblet2[,-1]

############################################################
# Interpretation
############################################################

# Ratios standardize measurements
# Removes scale differences between variables
