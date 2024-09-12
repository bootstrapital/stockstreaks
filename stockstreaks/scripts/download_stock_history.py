# Skipping the write to Backblaze B2 for now
# TODO: Figure out a strategy for writing to cloud storage and using during refresh process

import io
import os

import yfinance # TODO: replace with Tiingo API

import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

from b2sdk.v2 import InMemoryAccountInfo, B2Api
from dotenv import load_dotenv


load_dotenv(os.path.join(os.path.dirname(__file__), '..', '.env'))

# Backblaze B2 setup
# info = InMemoryAccountInfo()
# b2_api = B2Api(info)
# application_key_id = os.getenv('BACKBLAZE_KEY_ID')
# application_key = os.getenv('BACKBLAZE_KEY')
# bucket_name = os.getenv('BACKBLAZE_BUCKET')

# b2_api.authorize_account("production", application_key_id, application_key)
# bucket = b2_api.get_bucket_by_name(bucket_name)

symbols_df = pd.read_csv('../data/biggest-companies-stocks.csv')
symbols_list = symbols_df['Symbol'].to_list()

print(f'Downloading {len(symbols_list)} stocks from yfinance')
print('======================================================================')

for i, symbol in enumerate(symbols_list):
    print(symbol)
    ticker = yfinance.Ticker(symbol)
    df = ticker.history(period='max')
    df.reset_index(inplace=True)
    df['Ticker'] = symbol

    # Convert DataFrame to PyArrow Table
    table = pa.Table.from_pandas(df)
    print(symbol, df['Date'].max())

    # Write to in-memory buffer
    buffer = io.BytesIO()
    pq.write_table(table, buffer)
    buffer.seek(0)

    # Overwrite local file
    with open(f'../data/daily_history/{symbol}.parquet', 'wb') as f:
        f.write(buffer.getvalue())

    # Upload to B2
    # bucket.upload_bytes(buffer.getvalue(), file_name)

    print(f'Processed and uploaded {i+1} of {len(symbols_list)}: {symbol}')

# print("All Parquet files have been uploaded to Backblaze B2.")
