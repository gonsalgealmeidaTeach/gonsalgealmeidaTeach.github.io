############################################################
# Week 5: Goblet Data - Preprocessing & Visualization
############################################################

source("setup/install_packages.R")

library(MASS)

############################################################
# Load Data
############################################################

goblet <- read.csv("data/goblet.csv")

############################################################
# Feature Engineering
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
# Star Plot
############################################################

stars(goblet2[,-1],
      draw.segments = TRUE,
      main = "Goblet Star Plot",
      labels = goblet2$ID)

############################################################
# Parallel Coordinate Plot
############################################################

parcoord(goblet2[,-1],
         main = "Parallel Coordinate Plot")

############################################################
# Colored Parallel Plot
############################################################

col.w5 <- ifelse(goblet2$w5 <= median(goblet2$w5),
                 "red", "blue")

parcoord(goblet2[,-1],
         col = col.w5,
         main = "Parallel Coordinates (Colored)")
