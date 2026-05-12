provider "databricks" {
  host  = var.databricks_host
  token = var.databricks_token
}

resource "databricks_schema" "poc_schema" {
  catalog_name = var.catalog_name
  name         = var.schema_name
  comment      = "POC schema for interview demo"
}

resource "databricks_grants" "schema_grants" {
  schema = "${var.catalog_name}.${databricks_schema.poc_schema.name}"

  grant {
    principal  = var.data_engineering_group
    privileges = ["USE_SCHEMA", "SELECT", "MODIFY", "CREATE_TABLE", "CREATE_VIEW"]
  }
}

resource "databricks_cluster_policy" "shared_job_policy" {
  name = "poc-shared-job-policy"
  definition = jsonencode({
    autotermination_minutes = {
      type  = "fixed"
      value = 20
    }
    num_workers = {
      type    = "range"
      minValue = 1
      maxValue = 3
      defaultValue = 1
    }
  })
}

resource "databricks_cluster" "job_cluster" {
  cluster_name            = "poc-job-cluster"
  spark_version           = "13.3.x-scala2.12"
  node_type_id            = "Standard_DS3_v2"
  autotermination_minutes = 20
  num_workers             = 1
  policy_id               = databricks_cluster_policy.shared_job_policy.id
}

resource "databricks_job" "bronze_ingest" {
  name = "poc-bronze-ingest"

  existing_cluster_id = databricks_cluster.job_cluster.id

  spark_python_task {
    python_file = "dbfs:/FileStore/poc/src/jobs/bronze_ingest.py"
  }
}

resource "databricks_permissions" "bronze_job_permissions" {
  job_id = databricks_job.bronze_ingest.id

  access_control {
    group_name       = var.data_engineering_group
    permission_level = "CAN_MANAGE_RUN"
  }
}

resource "databricks_job" "silver_transform" {
  name = "poc-silver-transform"

  existing_cluster_id = databricks_cluster.job_cluster.id

  spark_python_task {
    python_file = "dbfs:/FileStore/poc/src/jobs/silver_transform.py"
  }
}

resource "databricks_permissions" "silver_job_permissions" {
  job_id = databricks_job.silver_transform.id

  access_control {
    group_name       = var.data_engineering_group
    permission_level = "CAN_MANAGE_RUN"
  }
}

resource "databricks_job" "gold_kpi" {
  name = "poc-gold-kpi"

  existing_cluster_id = databricks_cluster.job_cluster.id

  spark_python_task {
    python_file = "dbfs:/FileStore/poc/src/jobs/gold_kpi.py"
  }
}

resource "databricks_permissions" "gold_job_permissions" {
  job_id = databricks_job.gold_kpi.id

  access_control {
    group_name       = var.data_engineering_group
    permission_level = "CAN_MANAGE_RUN"
  }
}
