############################################################
# Week 4: Ordinal Regression
############################################################

library(MASS)

wheat$type_order <- factor(wheat$type,
                           levels = c("Scab", "Sprout", "Healthy"))

mod_ord <- polr(type_order ~ class + density + hardness + size + weight + moisture,
                data = wheat,
                method = "logistic")

summary(mod_ord)

############################################################
# Interpretation
############################################################

# - Ordinal regression models ordered categories
# - Useful when class levels have natural ranking
