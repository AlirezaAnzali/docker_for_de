select
    t.transaction_id,
    t.account_id,
    a.customer_id,
    t.transaction_date,
    t.transaction_type,
    t.amount
from {{ ref('stg_transactions') }} t
left join {{ ref('stg_accounts') }} a
    on t.account_id = a.account_id
