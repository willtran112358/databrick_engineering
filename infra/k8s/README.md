# Kubernetes Integration (Optional)

Databricks remains the primary compute plane for Spark/SQL workloads.
This folder shows how Kubernetes is commonly used as a **supporting platform layer** in industry:

- Run scheduled *platform glue* jobs (dbt, metadata sync, quality checks)
- Operate lightweight internal services (APIs, monitoring agents)
- Standardize runtime packaging (container images) across environments

See `manifests/` for example `CronJob` patterns.
