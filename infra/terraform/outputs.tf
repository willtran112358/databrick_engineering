output "schema_full_name" {
  value = "${databricks_schema.poc_schema.catalog_name}.${databricks_schema.poc_schema.name}"
}

output "cluster_id" {
  value = databricks_cluster.job_cluster.id
}

output "cluster_policy_id" {
  value = databricks_cluster_policy.shared_job_policy.id
}

output "job_ids" {
  value = {
    bronze = databricks_job.bronze_ingest.id
    silver = databricks_job.silver_transform.id
    gold   = databricks_job.gold_kpi.id
  }
}
