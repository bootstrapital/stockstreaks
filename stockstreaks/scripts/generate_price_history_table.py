import os

import duckdb

from b2sdk.v2 import InMemoryAccountInfo, B2Api
from dotenv import load_dotenv


load_dotenv(os.path.join(os.path.dirname(__file__), '..', '.env'))

# Backblaze B2 setup
# info = InMemoryAccountInfo()
# b2_api = B2Api(info)
# application_key_id = os.getenv('BACKBLAZE_KEY_ID')
# application_key = os.getenv('BACKBLAZE_KEY')
# bucket_name = os.getenv('BACKBLAZE_BUCKET')
# s3_endpoint = os.getenv('BACKBLAZE_S3_ENDPOINT')

# b2_api.authorize_account("production", application_key_id, application_key)
# bucket = b2_api.get_bucket_by_name(bucket_name)

# Connect to the DuckDB database
con = duckdb.connect('../data/strk.duckdb')

# Install and load the httpfs extension for DuckDB
# con.execute("INSTALL httpfs;")
# con.execute("LOAD httpfs;")

# Set up the S3 configuration for DuckDB
# con.execute(f"""
# SET s3_endpoint='{s3_endpoint}';
# SET s3_access_key_id='{application_key_id}';
# SET s3_secret_access_key='{application_key}';
# """)

# Ensure the price_history schema exists
con.execute('CREATE SCHEMA IF NOT EXISTS price_history')

# Drop the existing table if it exists
con.execute('DROP TABLE IF EXISTS price_history.daily')

print("Creating price_history.daily table from Parquet files in data/daily_history.")
print("    ")

# Create the table from Parquet files in B2
# query = f"""
# CREATE TABLE price_history.daily AS 
# SELECT * FROM read_parquet('s3://{bucket_name}/daily_history/*.parquet')
# """

query = f"""
CREATE TABLE price_history.daily AS 
SELECT * FROM read_parquet('../data/daily_history/*.parquet')
"""

try:
    con.execute(query)
    print("Successfully created price_history.daily table from local parquet files.")
    
    # Get the count of rows in the table
    result = con.execute('SELECT COUNT(*) FROM price_history.daily').fetchone()
    print(f"Total rows in price_history.daily: {result[0]}")
    
    # Get the list of unique tickers
    result = con.execute('SELECT COUNT(DISTINCT Ticker) FROM price_history.daily').fetchone()
    print(f"Number of unique tickers: {result[0]}")
    
except Exception as e:
    print(f"An error occurred: {str(e)}")

finally:
    # Close the connection
    con.close()
