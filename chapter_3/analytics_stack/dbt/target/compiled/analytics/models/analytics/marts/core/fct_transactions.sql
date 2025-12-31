select
    t.transaction_id,
    t.account_id,
    a.customer_id,
    t.transaction_date,
    t.transaction_type,
    t.amount
from "warehouse"."staging"."stg_transactions" t
left join "warehouse"."staging"."stg_accounts" a
    on t.account_id = a.account_id