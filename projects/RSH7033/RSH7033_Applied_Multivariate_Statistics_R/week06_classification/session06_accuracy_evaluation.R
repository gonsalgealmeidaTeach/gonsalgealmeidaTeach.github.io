############################################################
# Course: RSH7033 – Applied Multivariate Statistics
# Week 6: Classification Model Evaluation
# Description:
# This script evaluates classification model performance
# using cross-validation and validation metrics.
############################################################

# Load setup
source("setup/install_packages.R")

############################################################
# 1. Define Models
############################################################

method <- c("LDA (equal prior)", "LDA (proportional prior)",
            "QDA", "KNN (K=4)",
            "Logistic (cut=0.5)", "Logistic (cut=0.7)")

############################################################
# 2. Cross-Validation Results
############################################################

accuracy.cv <- c(0.7804, 0.8737, 0.8568, 0.8625, 0.8877, 0.8596)
se.cv <- c(0.7607, 0.9390, 0.9097, 0.9461, 0.9889, 0.9105)
sp.cv <- c(0.7829, 0.3681, 0.4479, 0.2147, 0.1043, 0.4663)

results.cv <- rbind(
  data.frame(method, accuracy = accuracy.cv, measure = "Overall"),
  data.frame(method, accuracy = se.cv, measure = "Sensitivity"),
  data.frame(method, accuracy = sp.cv, measure = "Specificity")
)

############################################################
# 3. Visualization
############################################################

library(lattice)

dotplot(method ~ accuracy | measure,
        data = results.cv,
        layout = c(1,3),
        xlab = "Accuracy",
        main = "Cross-Validation Results")

############################################################
# 4. Validation Results
############################################################

accuracy.v <- c(0.7624, 0.8546, 0.8404, 0.8723, 0.8475, 0.8440)
se.v <- c(0.7582, 0.9262, 0.9016, 0.9631, 0.9672, 0.9889)
sp.v <- c(0.7895, 0.3947, 0.4474, 0.2895, 0.0789, 0.1043)

results.v <- rbind(
  data.frame(method, accuracy = accuracy.v, measure = "Overall"),
  data.frame(method, accuracy = se.v, measure = "Sensitivity"),
  data.frame(method, accuracy = sp.v, measure = "Specificity")
)

dotplot(method ~ accuracy | measure,
        data = results.v,
        layout = c(1,3),
        xlab = "Accuracy",
        main = "Validation Results")

############################################################
# 5. Interpretation (CRITICAL)
############################################################

# Interpretation:
# - Accuracy measures overall classification performance
# - Sensitivity measures ability to detect positive cases
# - Specificity measures ability to detect negative cases
# - Different models trade off between sensitivity and specificity
