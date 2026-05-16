# MLOps Integration (Databricks + MLflow)

This folder demonstrates a practical MLOps extension for the platform:

1. Train a risk model from engineered features (`train_risk_model.py`)
2. Register model to Unity Catalog model registry (`register_model.py`)
3. Batch score incoming feature sets (`batch_score.py`)

## Typical Databricks Flow

1. Build features from `main.tymex_platform.v_risk_features`
2. Export or load features to training dataframe
3. Run training job with MLflow tracking
4. Register best model as `main.tymex_platform.risk_score_model`
5. Promote stages (Staging -> Production)
6. Run batch or serving inference

## Interview Q&A Highlights

- Why MLflow? Experiment tracking, reproducibility, model lineage.
- Why UC model registry? Governance, permissions, auditability.
- Where is monitoring? Add drift/performance jobs in Jenkins or Databricks Workflows.
