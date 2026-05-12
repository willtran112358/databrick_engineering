# AWS Integration Notes (Databricks on AWS)

## Typical setup

1. S3 as raw/curated storage zones
2. IAM role for Databricks cluster access to S3
3. Optional Kinesis for streaming ingestion
4. Optional Lambda + EventBridge for orchestration triggers

## Minimal IAM policy example (conceptual)

- Allow `s3:GetObject`, `s3:ListBucket` on raw bucket
- Allow `s3:PutObject` on curated/output bucket

## Interview talking points

- Why S3 + Delta: scalable object storage + ACID table semantics.
- Why IAM roles over keys: security and key-rotation simplicity.
- How to govern: Unity Catalog external locations and storage credentials.
