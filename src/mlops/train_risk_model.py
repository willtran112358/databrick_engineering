import mlflow
import mlflow.sklearn
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import roc_auc_score
from sklearn.model_selection import train_test_split


def load_features_csv(path: str) -> pd.DataFrame:
    return pd.read_csv(path)


def run_training(data_path: str, experiment_name: str) -> str:
    df = load_features_csv(data_path)

    feature_cols = ["txn_count_30d", "total_amount_30d", "avg_amount_30d", "failed_ratio_30d"]
    target_col = "is_high_risk"

    X = df[feature_cols]
    y = df[target_col]

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42, stratify=y)

    mlflow.set_experiment(experiment_name)
    with mlflow.start_run(run_name="rf-risk-model") as run:
        model = RandomForestClassifier(
            n_estimators=200,
            max_depth=6,
            random_state=42,
        )
        model.fit(X_train, y_train)

        preds = model.predict_proba(X_test)[:, 1]
        auc = roc_auc_score(y_test, preds)

        mlflow.log_param("model_type", "RandomForestClassifier")
        mlflow.log_param("n_estimators", 200)
        mlflow.log_param("max_depth", 6)
        mlflow.log_metric("auc", float(auc))

        mlflow.sklearn.log_model(model, artifact_path="model")
        return run.info.run_id


if __name__ == "__main__":
    run_id = run_training(
        data_path="sample_data/risk_features_training.csv",
        experiment_name="/Shared/poc-fintech-risk-model",
    )
    print(f"Training completed. run_id={run_id}")
