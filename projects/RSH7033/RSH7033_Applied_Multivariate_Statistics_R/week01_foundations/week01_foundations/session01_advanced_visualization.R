############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 1: Advanced Multivariate Visualization
# Dataset: cereal.csv (located in /data folder)
# Description:
# This script explores multivariate relationships using
# scatterplots, matrix plots, and advanced visualization tools.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Load Data
############################################################

cereal <- read.csv("data/cereal.csv")

# Adjust for serving size
cereal$sugar  <- cereal$sugar_g / cereal$size_g
cereal$fat    <- cereal$fat_g / cereal$size_g
cereal$sodium <- cereal$sodium_mg / cereal$size_g

vars <- cereal[, c("sugar", "fat", "sodium")]

############################################################
# 2. Scatterplot Matrix
############################################################

pairs(vars, main = "Scatterplot Matrix")

cor(vars)

# Interpretation:
# - Reveals pairwise relationships between variables
# - Strong linear patterns suggest correlation

############################################################
# 3. Enhanced Scatterplot Matrix
############################################################

library(car)

scatterplotMatrix(~ sugar + fat + sodium,
                  data = cereal,
                  diagonal = list(method = "histogram"),
                  main = "Enhanced Scatterplot Matrix")

############################################################
# 4. Colored Scatter Plot by Shelf
############################################################

shelf_colors <- c("black", "red", "darkgreen", "blue")

plot(cereal$sugar, cereal$fat,
     col = shelf_colors[cereal$Shelf],
     pch = cereal$Shelf,
     xlab = "Sugar",
     ylab = "Fat",
     main = "Fat vs Sugar by Shelf")

legend("topright",
       legend = 1:4,
       col = shelf_colors,
       pch = 1:4,
       title = "Shelf")

# Interpretation:
# - Color coding helps identify group patterns
# - Potential clustering by shelf location

############################################################
# 5. Bubble Plot (Sodium as Size)
############################################################

symbols(cereal$sugar, cereal$fat,
        circles = cereal$sodium,
        inches = 0.5,
        xlab = "Sugar",
        ylab = "Fat",
        main = "Bubble Plot (Size = Sodium)")

# Interpretation:
# - Larger bubbles indicate higher sodium content
# - Adds third variable dimension

############################################################
# 6. Parallel Coordinates Plot
############################################################

library(MASS)

parcoord(vars,
         col = shelf_colors[cereal$Shelf],
         main = "Parallel Coordinates Plot")

# Interpretation:
# - Shows multivariate profiles
# - Useful for detecting patterns across variables

############################################################
# 7. Star Plot
############################################################

stars(vars,
      draw.segments = TRUE,
      main = "Star Plot of Cereal Data")

############################################################
# 8. Optional: 3D Visualization (Advanced)
############################################################

# Note: May not work in all environments
# Uncomment if needed

# library(scatterplot3d)
# scatterplot3d(cereal$sugar, cereal$fat, cereal$sodium,
#               xlab = "Sugar",
#               ylab = "Fat",
#               zlab = "Sodium",
#               main = "3D Scatter Plot")

############################################################
# 9. Key Takeaways
############################################################

# - Multivariate data requires visualization beyond 2D
# - Relationships between variables can reveal structure
# - Visualization supports understanding before modeling
