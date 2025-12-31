
  
    

  create  table "warehouse"."analytics"."mart_customer_finance__dbt_tmp"
  
  
    as
  
  (
    with transactions as (

    select * from "warehouse"."analytics"."fct_transactions"

),

accounts as (

    select * from "warehouse"."analytics"."dim_accounts"

),

customers as (

    select * from "warehouse"."analytics"."dim_customers"

),

agg as (

    select
        customer_id,
        count(*) as total_transactions,
        sum(case when transaction_type = 'DEPOSIT' then amount else 0 end) as total_deposits,
        sum(case when transaction_type = 'WITHDRAWAL' then abs(amount) else 0 end) as total_withdrawals,
        sum(amount) as net_balance_change
    from transactions
    group by customer_id

)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.province_code,
    c.customer_since,
    coalesce(a.total_transactions, 0) as total_transactions,
    coalesce(a.total_deposits, 0) as total_deposits,
    coalesce(a.total_withdrawals, 0) as total_withdrawals,
    coalesce(a.net_balance_change, 0) as net_balance_change
from customers c
left join agg a
    on c.customer_id = a.customer_id
  );
  