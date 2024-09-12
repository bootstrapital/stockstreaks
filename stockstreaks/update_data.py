import subprocess
import os
import shutil
import argparse

def run_command(command, cwd=None):
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True, cwd=cwd, check=True, text=True, capture_output=True)
    print(result.stdout)
    if result.stderr:
        print(f"Errors: {result.stderr}")

def main():
    # Set up argument parser
    parser = argparse.ArgumentParser(description="Update stock data and generate reports.")
    parser.add_argument("--skip-download", action="store_true", help="Skip download and generate steps")
    args = parser.parse_args()

    # Assuming we start in the stockstreaks/stockstreaks directory

    if not args.skip_download:
        # Run download_stock_history.py
        run_command("python download_stock_history.py", cwd="scripts")

        # Run generate_price_history_table.py
        run_command("python generate_price_history_table.py", cwd="scripts")
    else:
        print("Skipping download and generate steps.")

    # Run dbt
    run_command("dbt run -m stg_daily_prices")

    # Copy the DuckDB file
    source = "./data/strk.duckdb"
    destination = "./reports/sources/strk/strk.duckdb"
    print(f"Copying {source} to {destination}")
    shutil.copy2(source, destination)

    # Run npm commands in the reports directory
    run_command("npm run sources", cwd="reports")
    run_command("npm run build", cwd="reports")

if __name__ == "__main__":
    main()