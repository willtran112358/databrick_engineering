from pyspark.sql import DataFrame, SparkSession
from pyspark.sql.functions import col, when


def transform_transactions(df: DataFrame) -> DataFrame:
    return (
        df.filter(col("amount").isNotNull())
        .filter(col("customer_id").isNotNull())
        .withColumn("amount", col("amount").cast("double"))
        .withColumn("currency", when(col("currency").isNull(), "USD").otherwise(col("currency")))
        .withColumn(
            "txn_status",
            when(col("txn_status").isin("SUCCESS", "FAILED", "PENDING"), col("txn_status")).otherwise("UNKNOWN"),
        )
    )


def run(input_table: str, output_table: str) -> None:
    spark = SparkSession.builder.appName("silver_transform").getOrCreate()
    input_df = spark.table(input_table)
    output_df = transform_transactions(input_df)

    (
        output_df.write.format("delta")
        .mode("overwrite")
        .option("overwriteSchema", "true")
        .saveAsTable(output_table)
    )


if __name__ == "__main__":
    run(
        input_table="main.poc_fintech.bronze_transactions",
        output_table="main.poc_fintech.silver_transactions",
    )
