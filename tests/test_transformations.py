from pyspark.sql import SparkSession

from src.jobs.silver_transform import transform_transactions


def test_transform_transactions_filters_and_defaults():
    spark = SparkSession.builder.master("local[1]").appName("unit-test").getOrCreate()

    data = [
        ("c1", "SUCCESS", 10.0, "USD"),
        ("c2", "INVALID_STATUS", 99.0, None),
        (None, "FAILED", 5.0, "USD"),
    ]
    df = spark.createDataFrame(data, ["customer_id", "txn_status", "amount", "currency"])

    result = transform_transactions(df).collect()
    by_customer = {r["customer_id"]: r for r in result}

    assert len(result) == 2
    assert by_customer["c2"]["currency"] == "USD"
    assert by_customer["c2"]["txn_status"] == "UNKNOWN"

    spark.stop()
