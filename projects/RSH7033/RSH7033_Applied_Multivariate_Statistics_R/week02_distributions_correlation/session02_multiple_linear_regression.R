################################################################################
# RSH7033 – Applied Multivariate Statistics
# Session 2: Multiple Linear Regression Analysis in R
################################################################################


############################################################
# Load Data
############################################################

data_oc <- read.csv(
  file.choose(),
  sep = "\t"
)


############################################################
# Checking distribution of variables and transformation
############################################################

data_oc2 <- data_oc[, !names(data_oc) %in% c("MDS1", "MDS2", "DCA1", "DCA2")]

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

hist(log10(data_oc2$DP))

data_oc2$DPlog <- log10(data_oc2$DP)


############################################################
# Checking for collinearity
############################################################

data_check <- data_oc2[, !names(data_oc2) %in% c("E100", "DP", "SR")]

pairs(data_check)


############################################################
# Enhanced correlation plot
############################################################

panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor) {

  usr <- par("usr")
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))

  r <- abs(cor(x, y, use = "complete.obs"))
  txt <- format(c(r, 0.123456789), digits = digits)[1]
  txt <- paste(prefix, txt, sep = "")

  if (missing(cex.cor)) {
    cex <- 0.8 / strwidth(txt)
  }

  test <- cor.test(x, y)

  Signif <- symnum(
    test$p.value,
    corr = FALSE,
    na = FALSE,
    cutpoints = c(0,0.05,0.1,1),
    symbols = c("*","."," ")
  )

  text(0.5,0.5,txt,cex = cex * r)
  text(.8,.8,Signif,cex = cex,col = 2)

}

pairs(
  data_check,
  lower.panel = panel.smooth,
  upper.panel = panel.cor
)


cor(data_check, use = "complete.obs")


############################################################
# Variance Inflation Factor
############################################################

mod_vif <- lm(data_oc2$E100 ~ ., data = data_check)

library(car)

vif(mod_vif)


mod_vifb <- lm(data_check$IC ~ ., data = data_check[, names(data_check) != "IC"])

summary(mod_vifb)

1 / (1 - 0.9363)


data_env <- data_check[, names(data_check) != "IC"]


############################################################
# Full Regression Model
############################################################

mod_1 <- lm(data_oc2$E100 ~ . + BT:DPlog,
            data = data_env,
            na.action = "na.fail")

summary(mod_1)


############################################################
# All Possible Models
############################################################

library(MuMIn)

models <- dredge(mod_1)

print(models)


############################################################
# Model Averaging
############################################################

mods <- get.models(models, subset = delta < 2)

mods

avg_model <- model.avg(mods)

summary(avg_model)


fit_y <- predict(avg_model)

res_var_avg <- sum((data_oc2$E100 - fit_y)^2)

tot_var_avg <- sum((data_oc2$E100 - mean(data_oc2$E100))^2)

1 - res_var_avg / tot_var_avg


############################################################
# Stepwise Model Reduction
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


par(mfrow = c(2,2))

plot(mod_5)

dev.off()


library(DAAG)

qreference(residuals(mod_5), nrep = 8)


############################################################
# Extract Model Information
############################################################

coef(mod_5)

confint(mod_5)

fitted(mod_5)

str(mod_5)


############################################################
# Partial F Tests
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


library(MuMIn)

AICc(mod_1)
AICc(mod_2)
AICc(mod_3)
AICc(mod_4)
AICc(mod_5)


K <- length(mod_5$coefficients) + 1

n <- nrow(data_check)

AIC(mod_5, k = 2) + 2 * K * (K + 1) / (n - K - 1)


############################################################
# Automatic Stepwise Modeling
############################################################

nullmodel <- lm(data_oc2$E100 ~ 1, data = data_env)

step(
  mod_1,
  direction = "backward",
  trace = 100,
  scope = list(upper = mod_1, lower = nullmodel),
  k = log(n)
)

step(
  nullmodel,
  direction = "forward",
  trace = 100,
  scope = list(upper = mod_1, lower = nullmodel),
  k = log(n)
)


############################################################
# Post-selection Shrinkage
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
# Bootstrapping Stepwise Models
############################################################

library(bootStepAIC)

data_env2 <- data_env

data_env2$resp_e100 <- data_oc2$E100

set.seed(1111)

boot.stepAIC(mod_1, data_env2, k = log(n), direction = "backward")

boot.stepAIC(mod_1, data_env2, k = 2, direction = "backward")


############################################################
# Selective Inference
############################################################

library(selectiveInference)

fs_model <- fs(as.matrix(data_env), data_oc2$E100)

plot(fs_model)

fsInf(fs_model)

coef(fs_model, s = 6)


############################################################
# LASSO Regression
############################################################

library(glmnet)

lasso_mod <- glmnet(as.matrix(data_env), data_oc2$E100)

par(cex = 1.5)

plot(lasso_mod, label = TRUE)

plot(lasso_mod, label = TRUE, xvar = "lambda")

plot(lasso_mod, label = TRUE, xvar = "dev")

coef(lasso_mod)


set.seed(222)

cvfit <- cv.glmnet(as.matrix(data_env), data_oc2$E100)

plot(cvfit)


set.seed(111)

cvfit2 <- cv.glmnet(
  as.matrix(data_env),
  data_oc2$E100,
  lambda = 10 ^ seq(-5, 0, 0.1)
)

plot(cvfit2)

cvfit2$lambda.min
cvfit2$lambda.1se


coef(cvfit2, s = "lambda.min")

coef(cvfit2, s = "lambda.1se")


############################################################
# Cross-Validation Function
############################################################

shrinkage <- function(fit, k = 10) {

  library(bootstrap)

  theta.fit <- function(x, y) {
    lsfit(x, y)
  }

  theta.predict <- function(fit, x) {
    cbind(1, x) %*% fit$coef
  }

  x <- fit$model[,2:ncol(fit$model)]
  y <- fit$model[,1]

  results <- crossval(x, y, theta.fit, theta.predict, ngroup = k)

  r2 <- cor(y, fit$fitted.values)^2
  r2cv <- cor(y, results$cv.fit)^2

  cat("Original R-square =", r2, "\n")
  cat(k, "Fold Cross-Validated R-square =", r2cv, "\n")
  cat("Change =", r2 - r2cv, "\n")

}

shrinkage(mod_4)

shrinkage(mod_5)


############################################################
# Variable Importance
############################################################

library(relaimpo)

pred_imp <- calc.relimp(
  mod_5,
  type = c("lmg","first","last","betasq"),
  rela = TRUE
)

plot(pred_imp)


library(hier.part)

hier.part(
  data_oc2$E100,
  data_env[, !(names(data_env) %in% "LAT")],
  gof = "Rsqu"
)


############################################################
# Example Dataset
############################################################

data("USairpollution", package = "HSAUR2")

head(USairpollution)
