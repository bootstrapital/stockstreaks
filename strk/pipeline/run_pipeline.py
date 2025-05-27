# pipeline/run_pipeline.py
# Main script to orchestrate the data pipeline.
# This script will be executed by the release_command in fly.toml.

import os
import json
import duckdb
# import dlt # Assuming dlt is used
# from sqlmesh.core.context import Context # Assuming SQLMesh is used

DATA_OUTPUT_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')
TICKERS_OUTPUT_DIR = os.path.join(DATA_OUTPUT_DIR, 'tickers')

def ensure_dir_exists(path):
    if not os.path.exists(path):
        os.makedirs(path)
    print(f"Directory ensured: {path}")

def run_dlt_pipeline():
    print("Simulating: Running dlt pipeline to ingest data into DuckDB...")
    # Placeholder for dlt pipeline execution
    # Example:
    # pipeline = dlt.pipeline(pipeline_name='stock_data',
    #                         destination='duckdb',
    #                         dataset_name='raw_stock_data')
    # source_data = your_dlt_source_function() # e.g., from dlt_sources.stock_source
    # load_info = pipeline.run(source_data)
    # print(load_info)
    print("Simulating: dlt pipeline finished.")

def run_sqlmesh_transformations():
    print("Simulating: Running SQLMesh transformations...")
    # Placeholder for SQLMesh execution
    # Example:
    # config_path = os.path.join(os.path.dirname(__file__), 'sqlmesh_project')
    # context = Context(paths=[config_path], config='local_duckdb') # Ensure config name matches
    # context.plan(auto_apply=True) # Or specific environment and plan application steps
    # print("SQLMesh plan applied.")
    print("Simulating: SQLMesh transformations finished.")

def export_data_to_json():
    print("Exporting data to JSON files...")
    ensure_dir_exists(DATA_OUTPUT_DIR)
    ensure_dir_exists(TICKERS_OUTPUT_DIR)

    # Example: Connect to DuckDB (path should align with dlt/sqlmesh config)
    db_path = os.path.join(os.path.dirname(__file__), '..', 'stock_data.duckdb') # Example path
    print(f"Connecting to DuckDB at: {db_path}")
    # conn = duckdb.connect(database=db_path, read_only=True) # Or False if creating/updating

    # --- Market Indices ---
    # Replace with actual queries to your transformed tables in DuckDB
    mock_market_indices = [
        {"name": "S&P 500", "symbol": "SPY", "currentPrice": "450.78", "dailyChange": "+1.25", "dailyChangePercent": "+0.28%", "streakType": "Win", "streakDuration": 3, "recentDays": ["Win", "Win", "Win", "Loss", "Win", "Loss", "Loss", "Win", "Neutral", "Win", "Win", "Loss", "Win"]},
        {"name": "Nasdaq 100", "symbol": "QQQ", "currentPrice": "380.50", "dailyChange": "-0.50", "dailyChangePercent": "-0.13%", "streakType": "Loss", "streakDuration": 1, "recentDays": ["Loss", "Win", "Win", "Win", "Loss", "Win", "Loss", "Loss", "Win", "Neutral", "Win", "Win", "Loss"]},
    ]
    with open(os.path.join(DATA_OUTPUT_DIR, 'market_indices.json'), 'w') as f:
        json.dump(mock_market_indices, f, indent=2)
    print(f"Generated: {os.path.join(DATA_OUTPUT_DIR, 'market_indices.json')}")

    # --- Notable Streaks ---
    mock_notable_streaks = [
        {"symbol": "STRK1", "companyName": "Streak Inc.", "currentPrice": "150.22", "dailyChange": "+2.30", "dailyChangePercent": "+1.55%", "streakType": "Win", "streakDuration": 9, "recentDays": ["Win"]*9 + ["Loss"]*4, "streakPercentageChange": "+12.5%", "specialIndicators": ["New High"]},
        {"symbol": "FALL1", "companyName": "Falling Co.", "currentPrice": "75.10", "dailyChange": "-1.10", "dailyChangePercent": "-1.45%", "streakType": "Loss", "streakDuration": 6, "recentDays": ["Loss"]*6 + ["Win"]*7, "streakPercentageChange": "-8.2%"}
    ]
    with open(os.path.join(DATA_OUTPUT_DIR, 'notable_streaks.json'), 'w') as f:
        json.dump(mock_notable_streaks, f, indent=2)
    print(f"Generated: {os.path.join(DATA_OUTPUT_DIR, 'notable_streaks.json')}")

    # --- Individual Tickers ---
    # This would typically loop through a list of tickers from your DB
    mock_tickers_data = {
        "AAPL": {"symbol": "AAPL", "companyName": "Apple Inc.", "currentPrice": "170.34", "dailyChange": "+1.00", "dailyChangePercent": "+0.59%", "lastUpdated": "4:00 PM May 27, 2025", "currentStreak": {"type": "Win", "duration": 2, "priceChange": "+2.50", "percentChange": "+1.48%"}, "longestWinStreak": {"duration": 8, "dateRange": "Mar 10 - Mar 19"}, "longestLossStreak": {"duration": 5, "dateRange": "Apr 01 - Apr 05"}, "volatility30Day": "1.8%", "priceHistory30Day": [{"date": "2025-04-28", "close": 168.00}], "recentStreaks": [{"type": "Win", "duration": "2 Days", "startDate": "May 26, 2025", "endDate": "May 27, 2025", "totalChange": "+2.50 (+1.48%)"}]},
        "STRK1": {"symbol": "STRK1", "companyName": "Streak Inc.", "currentPrice": "150.22", "dailyChange": "+2.30", "dailyChangePercent": "+1.55%", "lastUpdated": "4:00 PM May 27, 2025", "currentStreak": {"type": "Win", "duration": 9, "priceChange": "+16.70", "percentChange": "+12.5%"}, "longestWinStreak": {"duration": 9, "dateRange": "May 17 - May 27"}, "longestLossStreak": {"duration": 4, "dateRange": "Apr 20 - Apr 23"}, "volatility30Day": "2.2%", "priceHistory30Day": [{"date": "2025-04-28", "close": 130.00}], "recentStreaks": [{"type": "Win", "duration": "9 Days", "startDate": "May 17, 2025", "endDate": "May 27, 2025", "totalChange": "+16.70 (+12.5%)"}]},
    }
    for symbol, data in mock_tickers_data.items():
        with open(os.path.join(TICKERS_OUTPUT_DIR, f"{symbol}.json"), 'w') as f:
            json.dump(data, f, indent=2)
        print(f"Generated: {os.path.join(TICKERS_OUTPUT_DIR, f'{symbol}.json')}")

    # conn.close() # Close DuckDB connection
    print("JSON export finished.")

def main():
    print("Starting StockStreaks data pipeline...")
    run_dlt_pipeline()
    run_sqlmesh_transformations()
    export_data_to_json()
    print("StockStreaks data pipeline finished successfully.")

if __name__ == "__main__":
    main()
