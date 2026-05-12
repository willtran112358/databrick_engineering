variable "databricks_host" {
  description = "Databricks workspace URL"
  type        = string
}

variable "databricks_token" {
  description = "Databricks personal access token"
  type        = string
  sensitive   = true
}

variable "catalog_name" {
  description = "Unity Catalog catalog"
  type        = string
  default     = "main"
}

variable "schema_name" {
  description = "Schema for POC objects"
  type        = string
  default     = "poc_fintech"
}

variable "data_engineering_group" {
  description = "Databricks group to grant schema usage and job permissions"
  type        = string
  default     = "data-engineering"
}
