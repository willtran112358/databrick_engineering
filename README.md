# Databricks Platform Engineering POC

This repository is a practical, interview-ready proof of concept for a modern data platform using tools commonly used in industry:

- Databricks (Spark + SQL + Delta Lake + Unity Catalog)
- Terraform (infrastructure as code)
- Jenkins (CI/CD for data workflows)
- Databricks Asset Bundles (job packaging/deployment model)
- Delta Live Tables style SQL pipeline (data quality-ready pattern)
- Python unit tests for transformation logic

## Architecture

1. **Bronze**: ingest raw transactions.
2. **Silver**: clean and standardize records.
3. **Gold**: compute customer analytics KPIs.
4. **SQL Analytics**: expose business-ready views for BI and risk.
5. **CI/CD**: run tests, package jobs, and deploy infrastructure.

## Repository Layout

- `src/jobs/` Spark jobs (bronze/silver/gold)
- `src/mlops/` MLflow training, registration, scoring examples
- `src/ai/genie/` Databricks Genie prompt and use-case playbook
- `src/integrations/aws/` AWS ingestion integration starter (S3 -> Delta)
- `dbt/` dbt project for SQL transformations on Databricks
- `sql/analytics/` SQL queries for reporting and risk features
- `infra/terraform/` Databricks infra provisioning
- `config/genie/` semantic model starter for NLQ experiences
- `jenkins/` Jenkins pipeline
- `dlt/` DLT SQL pipeline example
- `scripts/` one-click demo helpers
- `tests/` unit tests
- `sample_data/` local sample input for demo
- `docs/` interview talking points and demo script

## Quick Start (Local)

1. Create Python environment and install dependencies:
   - `python -m venv .venv`
   - `.venv\Scripts\activate` (Windows PowerShell)
   - `pip install -r requirements.txt`
2. Run tests:
   - `pytest -q`

## Databricks Deployment Flow

1. Configure Databricks auth (PAT or service principal).
2. Provision base resources with Terraform in `infra/terraform/`.
3. Deploy jobs via Bundle in `databricks.yml` (or via Terraform resources).
4. Build and deploy via Jenkins `jenkins/Jenkinsfile`.
4. Trigger jobs in order:
   - `bronze_ingest`
   - `silver_transform`
   - `gold_kpi`

## One-Command Demo Runner

- PowerShell:
  - `.\scripts\demo_run.ps1 -DatabricksHost "<workspace-url>" -DatabricksToken "<token>"`

## Demo Story for Interview

- Show how IaC creates repeatable environments.
- Show how Spark jobs implement medallion architecture.
- Show how SQL serves business stakeholders.
- Show how Jenkins enforces quality gates (tests + lint + deploy).
- Show where governance and quality checks fit in (Unity Catalog grants, cluster policy, DLT expectations pattern, tests).
- Show MLOps extension: MLflow tracking + model registry + batch scoring.
- Show GenAI extension: Databricks Genie prompt template + semantic layer.
- Show cloud integration: AWS S3 ingestion pattern with IAM-aligned access.
- Show analytics engineering: dbt staging/marts and data tests on Databricks.

## Notes

- This is a focused POC with realistic patterns, not production-hardened code.
- Replace placeholders (workspace URLs, token variables, catalog names) before real deployment.
