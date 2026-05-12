-- Customer 360 analytics view for BI dashboarding
CREATE OR REPLACE VIEW main.fintech_platform.v_customer_360 AS
SELECT
  customer_id,
  txn_count_30d,
  total_amount_30d,
  avg_amount_30d,
  failed_txn_30d,
  failed_ratio_30d,
  CASE
    WHEN total_amount_30d >= 5000 THEN 'HIGH_VALUE'
    WHEN total_amount_30d >= 1000 THEN 'MID_VALUE'
    ELSE 'LOW_VALUE'
  END AS value_segment
FROM main.fintech_platform.gold_customer_kpi;
