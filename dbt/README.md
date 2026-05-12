# dbt Integration (Databricks)

This folder provides a dbt starter setup for transforming curated Databricks tables into analytics marts.

## Components

- `dbt_project.yml`: dbt project config
- `profiles.yml.example`: Databricks connection profile template
- `models/staging/`: source-aligned staging models
- `models/marts/`: business-facing mart models
- `seeds/`: small reference seed data

## Run locally

1. Install dbt adapter:
   - `pip install dbt-databricks`
2. Copy `profiles.yml.example` to your dbt profile location.
3. Execute:
   - `dbt deps`
   - `dbt seed`
   - `dbt run`
   - `dbt test`
