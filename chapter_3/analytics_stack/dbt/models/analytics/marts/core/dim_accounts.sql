select
    a.account_id,
    a.customer_id,
    a.account_type,
    a.opened_date,
    a.account_status
from {{ ref('stg_accounts') }} a