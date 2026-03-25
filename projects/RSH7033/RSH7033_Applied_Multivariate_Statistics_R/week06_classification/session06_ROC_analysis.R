############################################################
# Week 6: ROC Analysis
############################################################

source("setup/install_packages.R")

library(ROCR)

pred_obj <- prediction(pi_hat, placekick$good)
perf <- performance(pred_obj, "sens", "fpr")

plot(perf, main = "ROC Curve")
grid()

auc <- performance(pred_obj, "auc")@y.values
auc
