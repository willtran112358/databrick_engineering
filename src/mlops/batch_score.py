import pandas as pd
import mlflow.pyfunc


def batch_score(model_uri: str, input_csv: str, output_csv: str) -> None:
    model = mlflow.pyfunc.load_model(model_uri)
    df = pd.read_csv(input_csv)

    feature_cols = ["txn_count_30d", "total_amount_30d", "avg_amount_30d", "failed_ratio_30d"]
    scores = model.predict(df[feature_cols])

    output = df.copy()
    output["risk_prediction"] = scores
    output.to_csv(output_csv, index=False)


if __name__ == "__main__":
    batch_score(
        model_uri="models:/main.tymex_platform.risk_score_model/Production",
        input_csv="sample_data/risk_features_scoring.csv",
        output_csv="sample_data/risk_scores_output.csv",
    )
    print("Batch scoring completed.")
