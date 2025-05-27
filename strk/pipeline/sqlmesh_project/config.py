# pipeline/sqlmesh_project/config.py
from sqlmesh.core.config import Config, DuckDBConnectionConfig # Example for DuckDB

# Define the SQLMesh config for your project
# This example uses a local DuckDB file.
# The path is relative to THIS config.py file.
# Ensure your dlt pipeline writes to this same DuckDB file.
DUCKDB_FILE = "../../stock_data.duckdb" # Adjust path as needed

config = Config(
    default_connection=DuckDBConnectionConfig(database=DUCKDB_FILE),
    # You can define multiple connection environments e.g., local, dev, prod
    connections={
        "local_duckdb": DuckDBConnectionConfig(database=DUCKDB_FILE)
    },
    # default_test_connection=DuckDBConnectionConfig(database=":memory:"), # For unit tests
    # model_defaults=...,
    # ... other SQLMesh configurations
    # Specify that models are in the 'models' subdirectory
    model_loader_kwargs={"path": "models"}
)
