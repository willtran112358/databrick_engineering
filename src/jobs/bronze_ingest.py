from pyspark.sql import SparkSession
from pyspark.sql.functions import col, current_timestamp, to_timestamp


def run(input_path: str, output_table: str) -> None:
    spark = SparkSession.builder.appName("bronze_ingest").getOrCreate()

    df = (
        spark.read.option("header", "true")
        .option("inferSchema", "true")
        .csv(input_path)
        .withColumn("event_ts", to_timestamp(col("event_ts")))
        .withColumn("ingest_ts", current_timestamp())
    )

    (
        df.write.format("delta")
        .mode("append")
        .saveAsTable(output_table)
    )


if __name__ == "__main__":
    run(
        input_path="/dbfs/FileStore/sample/transactions.csv",
        output_table="main.tymex_platform.bronze_transactions",
    )
