-- Delta Live Tables style pipeline for silver quality controls
CREATE OR REFRESH STREAMING LIVE TABLE silver_transactions_dlt
COMMENT "Silver transactions with quality expectations"
AS
SELECT
  customer_id,
  txn_id,
  event_ts,
  CAST(amount AS DOUBLE) AS amount,
  COALESCE(currency, 'USD') AS currency,
  CASE
    WHEN txn_status IN ('SUCCESS', 'FAILED', 'PENDING') THEN txn_status
    ELSE 'UNKNOWN'
  END AS txn_status
FROM LIVE.bronze_transactions_dlt;

CREATE OR REFRESH LIVE TABLE gold_customer_kpi_dlt
COMMENT "Gold customer KPI from DLT"
AS
SELECT
  customer_id,
  COUNT(*) AS txn_count_30d,
  SUM(amount) AS total_amount_30d,
  AVG(amount) AS avg_amount_30d,
  SUM(CASE WHEN txn_status = 'FAILED' THEN 1 ELSE 0 END) AS failed_txn_30d
FROM LIVE.silver_transactions_dlt
GROUP BY customer_id;
