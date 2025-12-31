with src as (

    select * from {{ source('raw', 'transactions') }}

)

select
    txn_id as transaction_id,
    acct_id as account_id,
    case
        when txn_dt ~ '^\d{4}-\d{2}-\d{2}$'
            then txn_dt::date
        when txn_dt ~ '^\d{2}-\d{2}-\d{4}$'
            then to_date(txn_dt, 'MM-DD-YYYY')
        when txn_dt ~ '^\d{2}/\d{2}/\d{4}$'
            then to_date(txn_dt, 'MM/DD/YYYY')
        when txn_dt ~ '^\d{4}/\d{2}/\d{2}$'
            then to_date(txn_dt, 'YYYY/MM/DD')
        when txn_dt ~ '^\d{4}\.\d{2}\.\d{2}$'
            then to_date(txn_dt, 'YYYY.MM.DD')
        else null
    end as transaction_date,
    case
        when lower(txn_desc) like '%dep%' then 'DEPOSIT'
        else 'WITHDRAWAL'
    end as transaction_type,
    case
        when lower(txn_desc) like '%dep%' then abs(amt::numeric)
        else -abs(amt::numeric)
    end as amount
from src
