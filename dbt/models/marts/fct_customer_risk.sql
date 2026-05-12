with base as (
    select * from {{ ref('stg_transactions') }}
),
thresholds as (
    select * from {{ ref('risk_thresholds') }}
)
select
    b.customer_id,
    b.txn_count_30d,
    b.total_amount_30d,
    b.avg_amount_30d,
    b.failed_txn_30d,
    b.failed_ratio_30d,
    case when b.failed_ratio_30d >= t.high_failure_ratio_threshold then 1 else 0 end as high_failure_flag,
    case when b.avg_amount_30d >= t.high_ticket_threshold then 1 else 0 end as high_ticket_flag
from base b
cross join thresholds t
