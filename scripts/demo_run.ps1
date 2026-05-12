param(
  [string]$DatabricksHost = $env:DATABRICKS_HOST,
  [string]$DatabricksToken = $env:DATABRICKS_TOKEN
)

if (-not $DatabricksHost -or -not $DatabricksToken) {
  Write-Error "Set DATABRICKS_HOST and DATABRICKS_TOKEN env vars, or pass parameters."
  exit 1
}

Write-Host "Running local unit tests..."
python -m pytest -q
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Applying Terraform..."
Push-Location "infra/terraform"
terraform init
if ($LASTEXITCODE -ne 0) { Pop-Location; exit $LASTEXITCODE }
terraform apply -auto-approve -var "databricks_host=$DatabricksHost" -var "databricks_token=$DatabricksToken"
if ($LASTEXITCODE -ne 0) { Pop-Location; exit $LASTEXITCODE }
Pop-Location

Write-Host "POC infrastructure applied. Next: upload src to DBFS and trigger jobs in Databricks."
