############################################################
# RSH7033 – Applied Multivariate Statistics
# Week 1: Simulation and Exploratory Statistical Methods
############################################################


########################################
# Permutation: Inference via shuffling #
########################################

set.seed(20)

pop1 <- rnorm(1000, mean = 100, sd = 4)

set.seed(20)

pop2 <- runif(1000, min = 50, max = 135)

mean(pop1)
mean(pop2)

par(mfrow = c(1,2), cex = 1.2)

hist(pop1)
hist(pop2)


##############################
# Sampling from populations
##############################

no_sam1 <- 30
no_sam2 <- 30

set.seed(50)
samp1 <- sample(pop1, no_sam1)

mean(samp1)

set.seed(30)
samp2 <- sample(pop2, no_sam2)

mean(samp2)

par(mfrow = c(1,2))

hist(samp1, breaks = 15)
hist(samp2, breaks = 15)

categ <- c(rep("Samp1", no_sam1), rep("Samp2", no_sam2))

data_vec <- c(samp1, samp2)

datafr <- data.frame(data_vec, categ)

names(datafr) <- c("Size","Pop_type")


########################################
# Function for mean difference
########################################

meanDif <- function(x, grp){
  mean(x[grp=="Samp1"]) - mean(x[grp=="Samp2"])
}

with(datafr, meanDif(Size,Pop_type))


########################################
# Permutation Test
########################################

library(permute)

perm_vec <- numeric(length = 10000)

N <- nrow(datafr)

set.seed(400)

for(i in seq_len(length(perm_vec)-1)){
  
  perm <- shuffle(N)
  
  perm_vec[i] <- with(datafr, meanDif(Size,Pop_type[perm]))
  
}

perm_vec[10000] <- with(datafr, meanDif(Size,Pop_type))

par(cex=1.2)

hist(perm_vec,
     breaks=20,
     main="",
     xlab="Mean difference (Pop1 - Pop2)")

rug(perm_vec[10000],col="red",lwd=2)


########################################
# Permutation p-values
########################################

Dbig <- sum(perm_vec >= perm_vec[10000])

Dbig / length(perm_vec)

Dbig2 <- sum(abs(perm_vec) >= perm_vec[10000])

Dbig2 / length(perm_vec)


########################################
# Permutational t-test
########################################

library(coin)

pvalue(
  oneway_test(Size ~ Pop_type,
              data=datafr,
              distribution=approximate(B=9999))
)


########################################
# Classical t-test
########################################

plot(Size ~ Pop_type, data=datafr)

med <- tapply(datafr$Size, datafr$Pop_type, median)

w <- datafr$Size - med[datafr$Pop_type]

plot(w ~ Pop_type, data=datafr)


########################################
# Beanplot
########################################

library(beanplot)

beanplot(w ~ Pop_type, data=datafr)


########################################
# Classical t-test result
########################################

body_t2 <- t.test(Size ~ Pop_type,
                  data=datafr,
                  var.equal=FALSE)

body_t2


########################################
# Checking Normal Distribution
########################################

qqnorm(datafr$Size[datafr$Pop_type=="Samp1"], datax=TRUE)

qqline(datafr$Size[datafr$Pop_type=="Samp1"], datax=TRUE)

library(DAAG)

qreference(datafr$Size[datafr$Pop_type=="Samp1"], nrep=8)


qqnorm(datafr$Size[datafr$Pop_type=="Samp2"], datax=TRUE)

qqline(datafr$Size[datafr$Pop_type=="Samp2"], datax=TRUE)

qreference(datafr$Size[datafr$Pop_type=="Samp2"], nrep=8)


########################################
# Histograms
########################################

hist(datafr$Size[datafr$Pop_type=="Samp2"], breaks=15)

hist(datafr$Size[datafr$Pop_type=="Samp2"], breaks=5)

hist(datafr$Size[datafr$Pop_type=="Samp2"],
     breaks=15,
     probability=TRUE,
     xlim=c(40,140))

dens <- density(datafr$Size[datafr$Pop_type=="Samp2"])

lines(dens)

dens2 <- dnorm(0:140,
               mean=mean(datafr$Size[datafr$Pop_type=="Samp2"]),
               sd=sd(datafr$Size[datafr$Pop_type=="Samp2"]))

lines(dens2,col="red")

summary(datafr$Size[datafr$Pop_type=="Samp2"])


########################################
# Example: normality tests and sample size
########################################

set.seed(3300)

x <- rbinom(15,5,0.6)

shapiro.test(x)

qreference(x,nrep=8)


########################################
# Bootstrapping
########################################

library(boot)

boot_samp1 <- boot(
  datafr[datafr$Pop_type=="Samp1",1],
  function(x,i){
    mean(x[i])
  },
  R=10000
)

plot(boot_samp1)

hist(boot_samp1$t,breaks=100)

cis <- boot.ci(boot_samp1,type="bca")

cis


########################################
# Linear Regression Example
########################################

library(vegan)

data(varechem)

head(varechem)

str(varechem)

mod_1 <- lm(S ~ K, data=varechem)

summary(mod_1)

plot(S ~ K, data=varechem)

par(las=1,cex=1.8)

plot(S ~ K, data=varechem,
     ylab="S mg/kg",
     xlab="K mg/kg")

abline(mod_1,lwd=2)


########################################
# Model diagnostics
########################################

par(mfrow=c(1,3))

plot(mod_1,which=1:3)

qreference(residuals(mod_1),nrep=8)


########################################
# Influential observations
########################################

par(mfrow=c(1,3))

plot(mod_1,which=4:6)

2*2/nrow(varechem)

dfbeta(mod_1)


########################################
# Leave-one-out example
########################################

mod_2 <- lm(S ~ K, data=varechem[-1,])

summary(mod_1)
summary(mod_2)

dfbeta(mod_1)[1,]


########################################
# Extract model information
########################################

coefficients(mod_1)

fitted(mod_1)

confint(mod_1)

residuals(mod_1)

rstandard(mod_1)

anova(mod_1)

str(mod_1)


########################################
# Bootstrapping regression model
########################################

library(car)

set.seed(30)

boot_mod_res <- Boot(mod_1,
                     f=coef,
                     R=9999,
                     method="residual")

confint(boot_mod_res,type="bca")

confint(mod_1)


set.seed(30)

boot_mod_case <- Boot(mod_1,
                      f=coef,
                      R=9999,
                      method="case")

confint(boot_mod_case,type="bca")


########################################
# Cross-validation
########################################

cv.lm(data=varechem,
      form.lm=formula(S~K),
      m=5,
      seed=30)

mean(mod_1$residuals^2)


########################################
# Cross-validated R²
########################################

shrinkage <- function(fit,k=5){
  
  library(bootstrap)
  
  theta.fit <- function(x,y){
    lsfit(x,y)
  }
  
  theta.predict <- function(fit,x){
    cbind(1,x) %*% fit$coef
  }
  
  x <- fit$model[,2:ncol(fit$model)]
  
  y <- fit$model[,1]
  
  results <- crossval(x,y,
                      theta.fit,
                      theta.predict,
                      ngroup=k)
  
  r2 <- cor(y,fit$fitted.values)^2
  
  r2cv <- cor(y,results$cv.fit)^2
  
  cat("Original R-square =",r2,"\n")
  
  cat(k,"Fold Cross-Validated R-square =",r2cv,"\n")
  
  cat("Change =",r2-r2cv,"\n")
}

shrinkage(mod_1)


########################################
# Load possum dataset
########################################

pos_dat <- read.table(
  url("/possum.csv"),
  dec=".",
  sep=";",
  header=TRUE,
  row.names=NULL
)

head(pos_dat)

str(pos_dat)

save(pos_dat,file="Possum.Rdata")
