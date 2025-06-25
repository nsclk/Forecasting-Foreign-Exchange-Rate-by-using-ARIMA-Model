# 📈 Forecasting-Foreign-Exchange-Rate-by-using-ARIMA-Model

This project performs time series analysis and forecasting of EUR/USD currency pair hourly data using the **Tradermade API** and **SARIMA models** in R. The analysis includes data acquisition, preprocessing, differencing, autocorrelation checks, and forecasting using seasonal ARIMA models.

## 🔧 Features

- Fetches hourly EUR/USD forex data from the [Tradermade API](https://tradermade.com/)
- Parses and structures time series data
- Visualizes price trends using line plots
- Applies differencing to test for stationarity
- Computes autocorrelations
- Fits a SARIMA model for forecasting future values

## 📦 Requirements

Make sure you have R installed with the following packages:

```r
install.packages(c(
  "quantmod", "readr", "pacman", "zoo", "xts", "astsa", "httr",
  "binancer", "jsonlite", "dplyr", "dygraphs", "tbl2xts", "lubridate"
))
```

## 📁 File Overview

- **main.R** – The main script that performs the entire pipeline from data fetching to forecasting.
- **API_KEY** – Replace this string inside the code with your own Tradermade API key.

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/eurusd-sarima-analysis.git
   cd eurusd-sarima-analysis
   ```

2. Open `main.R` in RStudio or your preferred IDE.

3. Replace `"API_KEY"` in the URL string with your actual [Tradermade API key](https://marketdata.tradermade.com/).

4. Run the script step by step to:
   - Retrieve hourly forex data
   - Visualize and prepare the data
   - Fit a SARIMA model
   - Forecast future price movements

## 📊 Key Steps

- **Data Retrieval:**
  ```r
  hour_req <- "https://marketdata.tradermade.com/api/v1/timeseries?currency=EURUSD&api_key=API_KEY&start_date=...&end_date=...&interval=hourly"
  ```

- **Preprocessing:**
  Clean and convert JSON data to a data frame and then to a time series (`xts`) object.

- **Visualization:**
  Line plots of open prices and their differences.

- **Stationarity & Differencing:**
  Uses `diff()` and `acf2()` functions to ensure the data is stationary for SARIMA modeling.

- **Modeling & Forecasting:**
  ```r
  sarima(eur_open, p = 2, d = 1, q = 3, P = 0, D = 1, Q = 1, S = 12)
  sarima.for(eur_open, n.ahead = 11, ...)
  ```

## 📌 Notes

- The script uses `acf2()` and `sarima()` functions from the `astsa` package.
- Ensure your time zone settings are compatible with the API timestamps.
- This script focuses on **open prices**; feel free to modify for close, high, or low prices.

## 📄 License

This project is licensed under the MIT License.

## 🙋‍♂️ Author

Enes Çelik – [LinkedIn](https://linkedin.com/in/yourprofile) • [GitHub](https://github.com/yourusername)

