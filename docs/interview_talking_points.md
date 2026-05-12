# Interview Talking Points (TymeX / Head of Data & Analytics)

## What this repository demonstrates

1. Platform engineering mindset:
   - Databricks environment provisioned with Terraform.
   - Reproducible jobs, schema setup, access controls, and cluster policy.
2. Data engineering best practice:
   - Medallion architecture (bronze/silver/gold).
   - Data quality controls in silver normalization + DLT pattern.
3. Analytics delivery:
   - Customer 360 and risk features SQL views.
4. DevSecOps/DataOps:
   - Jenkins pipeline with test gate and IaC deployment.
   - Databricks Asset Bundle for deployment standardization.
5. Runtime standardization:
   - Docker image ensures repeatable dev/CI environment.
   - Kubernetes CronJobs (optional) for scheduled “platform glue” (dbt runs, workflow triggers).

## Suggested demo flow (10-15 minutes)

1. Start from `README.md` and architecture.
2. Walk through `infra/terraform/main.tf` for infra-as-code + governance.
3. Show Spark jobs in `src/jobs/` and explain transformation contracts.
4. Show SQL in `sql/analytics/` as stakeholder-facing layer.
5. Show `dlt/pipeline.sql` for data quality-first pipeline design.
6. Show `databricks.yml` + `jenkins/Jenkinsfile` for deployment and CI/CD.
7. Run `scripts/demo_run.ps1` as one-command infrastructure + validation demo.
8. (Optional) Show `infra/docker/` and `infra/k8s/` to explain how teams operationalize dbt/utility jobs around Databricks.
9. End with how this can scale:
   - Add DLT expectations, Unity Catalog grants, cluster policies, and observability.

## Why this aligns with fintech data platform needs

- Fast iteration with controlled deployment.
- Clear lineage from raw events to risk-ready features.
- Foundation for compliance and governance via Databricks + IaC.
- Compatible with future MLOps extension (MLflow, model registry, monitoring).
