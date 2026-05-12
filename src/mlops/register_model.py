import mlflow


def register_model_from_run(run_id: str, model_name: str) -> str:
    model_uri = f"runs:/{run_id}/model"
    registered_model = mlflow.register_model(model_uri=model_uri, name=model_name)
    return registered_model.version


if __name__ == "__main__":
    # Replace with actual run_id from training job output.
    version = register_model_from_run(
        run_id="REPLACE_RUN_ID",
        model_name="main.poc_fintech.risk_score_model",
    )
    print(f"Model registered. version={version}")
