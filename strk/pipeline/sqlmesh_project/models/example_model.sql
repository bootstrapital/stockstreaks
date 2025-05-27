-- pipeline/sqlmesh_project/models/example_model.sql
-- This is a placeholder SQLMesh model.
-- Replace this with your actual data transformation logic.

MODEL (
  name stock_streaks.example_transformed_data, -- Example model name (schema.table_name)
  kind FULL, -- or INCREMENTAL, VIEW, etc.
  audits (assert_not_null(column=close_price)),
  description "An example model that selects and potentially transforms raw stock data."
);

-- Assuming you have a table `raw_stock_data.price_data_aapl` ingested by dlt
-- You'd typically have a staging model per source table first.
-- For this example, let's pretend there's a generic `raw_prices` table.

-- SELECT
--   ticker,
--   CAST(date AS DATE) AS price_date,
--   CAST("open" AS DOUBLE) AS open_price, -- Ensure column names are quoted if they are keywords or have spaces
--   CAST("high" AS DOUBLE) AS high_price,
--   CAST("low" AS DOUBLE) AS low_price,
--   CAST("close" AS DOUBLE) AS close_price,
--   CAST(volume AS BIGINT) AS volume
-- FROM raw_stock_data.some_raw_table -- Replace with your actual raw data table from dlt
-- WHERE ticker IS NOT NULL AND date IS NOT NULL;

-- Placeholder query:
SELECT
  'AAPL' AS ticker,
  CURRENT_DATE AS price_date,
  170.0 AS open_price,
  171.0 AS high_price,
  169.0 AS low_price,
  170.5 AS close_price,
  1000000 AS volume;
