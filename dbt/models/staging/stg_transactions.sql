select
    customer_id,
    txn_count_30d,
    total_amount_30d,
    avg_amount_30d,
    failed_txn_30d,
    failed_ratio_30d
from main.tymex_platform.gold_customer_kpi
