import duckdb
import pandas as pd
import yfinance


symbols_df = pd.read_csv('../data/biggest-companies-stocks.csv')
symbols_list = symbols_df['Symbol'].to_list()

dataframes = []

for i, symbol in enumerate(symbols_list):
    ticker = yfinance.Ticker(symbol)
    df = ticker.history(period='max')
    df.reset_index(inplace=True)

    df['Ticker'] = symbol

    dataframes.append(df)
    print(f'Processed {i+1} of {len(symbols_list)}: {symbol}')

all_data = pd.concat(dataframes)

con = duckdb.connect('../data/stsk.duckdb')
with con:
    con.execute('drop table if exists price_history.daily')
    con.execute('create table price_history.daily as select * from all_data')
