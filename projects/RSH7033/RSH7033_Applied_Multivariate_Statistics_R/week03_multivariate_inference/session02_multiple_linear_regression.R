################################################################################
# RSH7033 – Applied Multivariate Statistics with R
# Session 2: Multiple Linear Regression
################################################################################


############################################################
# Data Path (Local Repository Data Folder)
############################################################

data_path <- "../data/"


############################################################
# Load Required Packages
############################################################

packages <- c(
  "car",
  "MuMIn",
  "DAAG",
  "glmnet",
  "bootStepAIC",
  "selectiveInference",
  "relaimpo",
  "hier.part",
  "HSAUR2",
  "bootstrap"
)

installed <- packages %in% rownames(installed.packages())

if(any(installed == FALSE)){
  install.packages(packages[!installed])
}

lapply(packages, library, character.only = TRUE)


############################################################
# Load Data (Local File)
############################################################

data_oc <- read.csv(
  paste0(data_path,"OstraMRegS400JB.txt"),
  sep = "\t"
)



############################################################
# Research Question
############################################################

# Which patterns and environmental variables control
# the diversity of marine ostracods?



############################################################
# Remove Community Structure Variables
############################################################

data_oc2 <- data_oc[, !names(data_oc) %in% c("MDS1","MDS2","DCA1","DCA2")]



############################################################
# Check Variable Distributions
############################################################

par(mfrow = c(3,3))

hist(data_oc2$DP)
hist(data_oc2$RC)
hist(data_oc2$BT)
hist(data_oc2$SA)
hist(data_oc2$SP)
hist(data_oc2$IC)
hist(data_oc2$P)
hist(data_oc2$LAT)
hist(data_oc2$LON)

dev.off()



############################################################
# Transform Depth Variable
############################################################

hist(log10(data_oc2$DP))

data_oc2$DPlog <- log10(data_oc2$DP)



############################################################
# Check Collinearity
############################################################

data_check <- data_oc2[, !names(data_oc2) %in% c("E100","DP","SR")]

pairs(data_check)



############################################################
# Correlation Panel Function
############################################################

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor){

  usr <- par("usr")
  on.exit(par(usr))

  par(usr = c(0,1,0,1))

  r <- abs(cor(x,y,use="complete.obs"))

  txt <- format(c(r,0.123456789), digits=digits)[1]

  txt <- paste(prefix,txt,sep="")

  if(missing(cex.cor)){
    cex <- 0.8/strwidth(txt)
  }

  test <- cor.test(x,y)

  Signif <- symnum(
    test$p.value,
    corr = FALSE,
    na = FALSE,
    cutpoints = c(0,0.05,0.1,1),
    symbols = c("*","."," ")
  )

  text(0.5,0.5,txt,cex = cex*r)
  text(.8,.8,Signif,cex=cex,col=2)

}



pairs(
  data_check,
  lower.panel = panel.smooth,
  upper.panel = panel.cor
)



############################################################
# Correlation Matrix
############################################################

cor(data_check,use="complete.obs")



############################################################
# Variance Inflation Factor
############################################################

mod_vif <- lm(data_oc2$E100 ~ ., data = data_check)

vif(mod_vif)



############################################################
# Remove IC Variable
############################################################

data_env <- data_check[, names(data_check) != "IC"]



############################################################
# Full Regression Model
############################################################

mod_1 <- lm(
  data_oc2$E100 ~ . + BT:DPlog,
  data = data_env,
  na.action = "na.fail"
)

summary(mod_1)



############################################################
# Compute All Possible Models
############################################################

models <- dredge(mod_1)

print(models)



############################################################
# Model Averaging
############################################################

mods <- get.models(models, subset = delta < 2)

mods

avg_model <- model.avg(mods)

summary(avg_model)



############################################################
# Calculate R² for Averaged Model
############################################################

fit_y <- predict(avg_model)

res_var_avg <- sum((data_oc2$E100 - fit_y)^2)

tot_var_avg <- sum((data_oc2$E100 - mean(data_oc2$E100))^2)

1 - res_var_avg / tot_var_avg



############################################################
# Stepwise Backward Selection
############################################################

summary(mod_1)

mod_2 <- update(mod_1, ~ . - BT:DPlog)

summary(mod_2)

mod_3 <- update(mod_2, ~ . - LAT)

summary(mod_3)

mod_4 <- update(mod_3, ~ . - SA)

summary(mod_4)

mod_5 <- update(mod_4, ~ . - RC)

summary(mod_5)



############################################################
# Model Diagnostics
############################################################

par(mfrow = c(2,2))

plot(mod_5)

dev.off()



############################################################
# Residual Normality Check
############################################################

qreference(residuals(mod_5), nrep = 8)



############################################################
# Extract Model Information
############################################################

coef(mod_5)

confint(mod_5)

fitted(mod_5)

str(mod_5)



############################################################
# Partial F Test Between Models
############################################################

anova(mod_1, mod_2)

anova(mod_2, mod_3)

anova(mod_1, mod_3)

anova(mod_1, mod_4)

anova(mod_1, mod_5)



############################################################
# Information Criteria
############################################################

AIC(mod_1)
AIC(mod_2)
AIC(mod_3)
AIC(mod_4)
AIC(mod_5)

BIC(mod_1)
BIC(mod_2)
BIC(mod_3)
BIC(mod_4)
BIC(mod_5)



############################################################
# Corrected AIC
############################################################

K <- length(mod_5$coefficients) + 1

n <- nrow(data_check)

AIC(mod_5, k = 2) + 2 * K * (K + 1) / (n - K - 1)



############################################################
# Automatic Stepwise Model Selection
############################################################

nullmodel <- lm(data_oc2$E100 ~ 1, data = data_env)

step(
  mod_1,
  direction = "backward",
  trace = 100,
  scope = list(upper = mod_1, lower = nullmodel),
  k = log(n)
)



############################################################
# Post Selection Shrinkage
############################################################

library(shrink)

mod_5_s <- lm(
  data_oc2$E100 ~ . - LAT - RC - SA,
  data = data_env,
  x = TRUE,
  y = TRUE
)

shrink_res1 <- shrink(mod_5_s, type = "global")

shrink_res1

coef(mod_5_s)[-1] * shrink_res1$ShrinkageFactors

shrink_res2 <- shrink(mod_5_s, type = "parameterwise")

shrink_res2



############################################################
# LASSO Regression
############################################################

lasso_mod <- glmnet(
  as.matrix(data_env),
  data_oc2$E100
)

par(cex = 1.5)

plot(lasso_mod,label = TRUE)



############################################################
# Cross Validation for LASSO
############################################################

set.seed(222)

cvfit <- cv.glmnet(
  as.matrix(data_env),
  data_oc2$E100
)

plot(cvfit)

cvfit$lambda.min

cvfit$lambda.1se



############################################################
# Variable Importance
############################################################

pred_imp <- calc.relimp(
  mod_5,
  type = c("lmg","first","last","betasq"),
  rela = TRUE
)

plot(pred_imp)



############################################################
# Hierarchical Partitioning
############################################################

hier.part(
  data_oc2$E100,
  data_env[, !(names(data_env) %in% "LAT")],
  gof = "Rsqu"
)



############################################################
# Exercise Dataset
############################################################

data("USairpollution", package = "HSAUR2")

head(USairpollution)
