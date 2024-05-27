import duckdb
import pandas as pd
import yfinance


symbols = [
    'SPY',
    'AAPL',
    'MSFT',
    'AMZN',
    'GOOG',
    'NVDA',
]

dataframes = []

for symbol in symbols:
    ticker = yfinance.Ticker(symbol)
    df = ticker.history(period='max')
    df.reset_index(inplace=True)

    df['Ticker'] = symbol

    dataframes.append(df)

all_data = pd.concat(dataframes)

con = duckdb.connect('data/data.duckdb')
with con:
    con.execute('create or replace table history as select * from all_data')
