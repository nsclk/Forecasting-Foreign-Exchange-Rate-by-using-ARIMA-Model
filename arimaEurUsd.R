# Load necessary libraries
library(quantmod)   # For financial data analysis
library(readr)      # For reading CSV data
library(pacman)     # For package management
library(zoo)        # For working with time series data
library(xts)        # For creating time series objects
library(astsa)      # For time series analysis
library(httr)       # For HTTP requests
library(binancer)   # For accessing Binance API
library(jsonlite)   # For JSON data processing
library(dplyr)      # For data manipulation
library(dygraphs)   # For interactive graphs
library(tbl2xts)    # For converting data frames to xts
library(lubridate)  # For date and time manipulation

# URL for hourly data request from Tradermade API for EURUSD currency pair
hour_req <- "https://marketdata.tradermade.com/api/v1/timeseries?currency=EURUSD&api_key="API_KEY"&start_date=2024-04-02-08:00&end_date=2024-04-09-07:00&format=records&interval=hourly"

# Retrieve data using HTTP GET request
data_hour_raw <- GET(url = hour_req)

# Extract content from the raw data as text
data_hour_text <- content(data_hour_raw, "text", encoding = "UTF-8")

# Convert JSON text to a list
data_hour_json <- fromJSON(data_hour_text, flatten=TRUE)

# Convert the list to a data frame, specifically extracting the 'quotes' list
dataframe_hour <- as.data.frame(data_hour_json["quotes"])

# Specify the order of columns to retain
col_order <- c("quotes.date", "quotes.open", "quotes.close",
               "quotes.high", "quotes.low")

# Subset and reorder the dataframe based on 'col_order'
eur_usd <- dataframe_hour[, col_order]

# Rename columns to more user-friendly names
names(eur_usd)[1] <- "date"
names(eur_usd)[2] <- "open"
names(eur_usd)[3] <- "close"
names(eur_usd)[4] <- "high"
names(eur_usd)[5] <- "low"

# Convert the 'date' column to datetime format
eur_usd$date <- ymd_hms(eur_usd$date)

# Further subset the data frame to relevant columns for time series analysis
eur_usd <- eur_usd[, c("date", "open", "high", "low", "close")]

# Convert the data frame to an xts object for time series operations
eur_usd_xts <- as.xts(eur_usd)

# Plot line graph for Ethereum price components (open prices)
plot(eur_usd$date,      # X-axis: time
     eur_usd$open,           # Y-axis: open prices
     type = "l",              # Line plot
     col = 2,                 # Line color
     xlab = "time",           # X-axis label
     ylab = "prices")         # Y-axis label

# Calculate the first difference of opening prices to make the data stationary
d_eur_open <- diff(eur_open)

# Plot the differenced data to observe stationarity
plot(d_eur_open)
lines(d_eur_open)  # Add lines to enhance visual representation

# Compute autocorrelation for the differenced opening prices
acf2(d_eur_open, max.lag = 60)

# Calculate second difference of the differenced data to ensure complete stationarity
dd_eur_open <- diff(d_eur_open)

# Plot the second differenced data for analysis
plot(dd_eur_open)
lines(dd_eur_open)  # Add lines to enhance visual representation

# Compute autocorrelation for the second differenced data
acf2(dd_eur_open, max.lag = 60)

# Fit a Seasonal ARIMA model to the original opening prices
sarima(eur_open, p = 2, d = 1, q = 3, P = 0, D = 1, Q = 1, S = 12)

# Forecast future Ethereum opening prices using the fitted SARIMA model
sarima.for(eur_open, n.ahead = 11, p = 2, d = 1, q = 3, P = 0, D = 1, Q = 1, S = 12)
