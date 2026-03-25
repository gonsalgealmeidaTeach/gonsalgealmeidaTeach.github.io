# --------------------------------------------------
# Course: RSH 7033 Applied Multivariate Statistics
# File: install_packages.R
# Purpose: Install and load required R packages
# --------------------------------------------------

# List of required packages
required_packages <- c(
  "tidyverse",
  "mvtnorm",
  "MASS",
  "ggplot2",
  "cluster",
  "factoextra",
  "corrplot",
  "GGally"
)

# Check which packages are already installed
installed_packages <- rownames(installed.packages())

# Identify missing packages
missing_packages <- setdiff(required_packages, installed_packages)

# Install only missing packages
if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

# Load all packages
lapply(required_packages, library, character.only = TRUE)

# Confirmation message
cat("All required packages are installed and loaded successfully.\n")
