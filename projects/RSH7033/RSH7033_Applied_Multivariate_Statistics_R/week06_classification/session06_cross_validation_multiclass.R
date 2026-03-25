############################################################
# Week 6: Cross-Validation (Multiclass)
############################################################

cv_multinom <- function(model, data.set) {
  N <- nrow(data.set)
  class.cv <- character(N)

  for (i in 1:N) {
    mod <- multinom(model, data = data.set[-i,], trace = FALSE)
    class.cv[i] <- as.character(
      predict(mod, newdata = data.set[i,], type = "class")
    )
  }

  class.cv
}

pred_cv <- cv_multinom(type ~ class + density + hardness + size + weight + moisture,
                       wheat)

table(wheat$type, pred_cv)
