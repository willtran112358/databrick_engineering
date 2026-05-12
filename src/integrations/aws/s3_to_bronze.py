from pyspark.sql import SparkSession
from pyspark.sql.functions import current_timestamp


def run(
    s3_path: str,
    output_table: str,
    file_format: str = "parquet",
) -> None:
    spark = SparkSession.builder.appName("aws_s3_to_bronze").getOrCreate()

    df = spark.read.format(file_format).load(s3_path).withColumn("ingest_ts", current_timestamp())

    (
        df.write.format("delta")
        .mode("append")
        .saveAsTable(output_table)
    )


if __name__ == "__main__":
    run(
        s3_path="s3://your-fintech-raw-zone/transactions/",
        output_table="main.fintech_platform.bronze_transactions",
        file_format="parquet",
    )
