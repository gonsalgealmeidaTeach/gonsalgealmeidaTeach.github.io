############################################################
# Week 8: Download Stock Data and Create Returns Dataset
############################################################

source("setup/install_packages.R")

library(quantmod)

############################################################
# 1. Define Tickers
############################################################

tickers <- c("MSFT", "AMZN", "KO", "MA", "COST", 
             "LUV", "XOM", "PFE", "JPM", "UNH", 
             "ACN", "DIS", "GILD", "TSLA","NVDA",
             "AAPL","AMD","F","SOS","RGS")

############################################################
# 2. Download Data
############################################################

getSymbols(tickers, from = "2020-01-01", to = "2024-01-01")

############################################################
# 3. Extract Adjusted Prices
############################################################

prices_list <- lapply(tickers, function(tk) {
  Ad(get(tk))
})

prices <- do.call(merge, prices_list)

colnames(prices) <- tickers

head(prices)

############################################################
# 4. Compute Returns
############################################################

returns <- na.omit(ROC(prices, type = "discrete"))

head(returns)

############################################################
# 5. Convert to Data Frame
############################################################

returns_df <- data.frame(date = index(returns), coredata(returns))

############################################################
# 6. Save to Data Folder
############################################################

write.csv(returns_df, "data/portfolio_returns.csv", row.names = FALSE)

############################################################
# Interpretation
############################################################

# This creates a reproducible dataset for portfolio analysis
