############################################################
# Week 6: Handling Factors in R (Supporting Script)
############################################################

############################################################
# Example 1: Character to Factor
############################################################

set1 <- data.frame(
  cat.var = factor(c("D", "A", "A", "B", "D",
                     "C", "1", "0", "1", "b"))
)

set1

class(set1$cat.var)
levels(set1$cat.var)

############################################################
# Example 2: Numeric vs Factor
############################################################

set2 <- data.frame(
  num.var = c(0,1,0,0,1)
)

set2

class(set2$num.var)

factor_var <- factor(set2$num.var)

class(factor_var)
levels(factor_var)

############################################################
# Interpretation
############################################################

# Factors represent categorical variables
# Numeric values are NOT automatically treated as categories
# Many classification methods require factors as input
