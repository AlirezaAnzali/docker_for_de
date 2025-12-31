
  create view "warehouse"."staging"."stg_accounts__dbt_tmp"
    
    
  as (
    with src as (

    select * from "warehouse"."raw"."accounts"

)

select
    acct_id as account_id,
    cust_id as customer_id,
    case
        when lower(type) in ('chk', 'checking') then 'CHECKING'
        when lower(type) in ('sav', 'savings') then 'SAVINGS'
        else 'UNKNOWN'
    end as account_type,
    case
        when open_date ~ '^\d{4}-\d{2}-\d{2}$'
            then open_date::date
        when open_date ~ '^\d{2}-\d{2}-\d{4}$'
            then to_date(open_date, 'MM-DD-YYYY')
        when open_date ~ '^\d{2}/\d{2}/\d{4}$'
            then to_date(open_date, 'MM/DD/YYYY')
        when open_date ~ '^\d{4}/\d{2}/\d{2}$'
            then to_date(open_date, 'YYYY/MM/DD')
        when open_date ~ '^\d{4}\.\d{2}\.\d{2}$'
            then to_date(open_date, 'YYYY.MM.DD')
        else null
    end as opened_date,
    case
        when status_flag = '1' then 'ACTIVE'
        else 'CLOSED'
    end as account_status
from src
  );