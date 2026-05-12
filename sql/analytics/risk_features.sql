-- Risk-focused feature view consumed by model training and monitoring
CREATE OR REPLACE VIEW main.fintech_platform.v_risk_features AS
SELECT
  customer_id,
  txn_count_30d,
  total_amount_30d,
  avg_amount_30d,
  failed_txn_30d,
  failed_ratio_30d,
  CASE
    WHEN failed_ratio_30d > 0.30 THEN 1 ELSE 0
  END AS high_failure_flag,
  CASE
    WHEN txn_count_30d = 0 THEN 0
    WHEN avg_amount_30d > 800 THEN 1 ELSE 0
  END AS unusual_ticket_size_flag
FROM main.fintech_platform.gold_customer_kpi;
