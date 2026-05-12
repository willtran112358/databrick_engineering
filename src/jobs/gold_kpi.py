from pyspark.sql import SparkSession
from pyspark.sql.functions import avg, count, expr, sum, when


def run(input_table: str, output_table: str) -> None:
    spark = SparkSession.builder.appName("gold_kpi").getOrCreate()

    df = spark.table(input_table)
    gold = (
        df.groupBy("customer_id")
        .agg(
            count("*").alias("txn_count_30d"),
            sum("amount").alias("total_amount_30d"),
            avg("amount").alias("avg_amount_30d"),
            sum(when(df.txn_status == "FAILED", 1).otherwise(0)).alias("failed_txn_30d"),
        )
        .withColumn(
            "failed_ratio_30d",
            expr("CASE WHEN txn_count_30d = 0 THEN 0 ELSE failed_txn_30d / txn_count_30d END"),
        )
    )

    (
        gold.write.format("delta")
        .mode("overwrite")
        .option("overwriteSchema", "true")
        .saveAsTable(output_table)
    )


if __name__ == "__main__":
    run(
        input_table="main.poc_fintech.silver_transactions",
        output_table="main.poc_fintech.gold_customer_kpi",
    )
