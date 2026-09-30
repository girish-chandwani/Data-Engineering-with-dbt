# NYC Parking Violations: Data Engineering with dbt

This project uses dbt and DuckDB to transform New York City parking violation
data into analytics-ready models. The dbt project is in
[`nyc_parking_violations/`](nyc_parking_violations/).

## Data and models

The [`data/`](data/) directory contains sample fiscal year 2023 parking
violations and the parking violation code reference data. The dbt models are
organized into three layers:

- **Bronze**: views over the source parking violation and violation-code data.
- **Silver**: cleaned and organized violation, ticket, vehicle, and code models.
- **Gold**: ticket and vehicle metrics for analysis.

The compiled database is configured at `data/prod_nyc_parking_violations.db`.
The notebook [`run_sql_queries_here.ipynb`](run_sql_queries_here.ipynb) is
available for running SQL queries against the data.

## Setup

Use Python 3 and install the dependencies from the repository root:

```bash
python -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

The dependencies include dbt Core and the DuckDB adapter. The dbt profile is
provided in `nyc_parking_violations/profiles.yml`. Run dbt commands from that
directory so the relative DuckDB path in the profile resolves correctly.

## Run the dbt project

From the repository root, enter the dbt project directory, then validate the
connection and build the models:

```bash
cd nyc_parking_violations
dbt debug --profiles-dir .
dbt run --profiles-dir .
dbt test --profiles-dir .
```

The gold models are materialized as tables. dbt build artifacts and the local
DuckDB database are generated locally and are excluded from Git.

## Explore dbt docs and lineage

After running the models above, generate and serve the docs from the repository
root:

```bash
cd nyc_parking_violations
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .
```

Open the local URL printed by `dbt docs serve` (by default,
`http://localhost:8080`). The docs site includes model descriptions, columns,
tests, and an interactive lineage graph. Use the graph to trace dependencies
between the bronze, silver, and gold models, and select a model to inspect its
upstream and downstream dependencies. Regenerate the docs after changing the
project to refresh the graph and metadata.