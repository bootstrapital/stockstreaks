# Stock Streaks
Interday stock trading patterns

### Architecture
- Stock data is downloaded from [yfinance](https://pypi.org/project/yfinance/) and stored in a [duckdb](https://duckdb.org/) database.
- We then use [dbt](https://docs.getdbt.com/docs/introduction) to model the raw data and [Evidence](https://docs.evidence.dev) to display the visualizations.
- The Evidence project is deployed to the web using Netlify.

### Dev Environment
Note: This documentation is very much a work in progress

**TODO:**
- [ ] Replace yfinance data source with Tiingo API
- [ ] Replace [basic script](/scripts/download_stock_history.py) with `dlt` for raw data ingestion. [dlt](https://dlthub.com/) is a python library for easily building robust data pipelines.
- [ ] Write raw data to s3 buckets per stock symbol
- [ ] Write ingestion pipeline to load data from s3 buckets to duckdb database

#### Installation
- Make sure you have Python 3.12 installed
- Navigate to the `stockstreaks` directory
- Create a virtual environment using `python -m venv .venv`
- Activate the virtual environment using `source .venv/bin/activate`
- Install the required packages using `pip install -r requirements.txt`


#### Running the project (basics)
- cd into the `stockstreaks` source code directory (you should be in `stockstreaks/stockstreaks`)
- Run `python scripts/download_stock_history.py` to download stock data from yfinance and store it in a duckdb database
- Run `dbt deps` to install the required dbt packages (we're not using anything for now but it's a good practice to run this first)
- Run `dbt run` to run the data transformations and generate the core models
- Run `npm --prefix ./reports install` to ensure you have the latest version of Evidence installed
- Run `npm --prefix ./reports run sources` to build the Evidence project
- Run `npm --prefix ./reports run dev` to start the server locally

Some other useful commands:
- Run `dbt test` to run the tests (TBD)
- Run `dbt docs generate` to generate the transformation documentation
- Run `dbt docs serve` to serve the model documentation locally (will be useful once architeture evolves)