
  
    

  create  table "warehouse"."analytics"."dim_accounts__dbt_tmp"
  
  
    as
  
  (
    select
    a.account_id,
    a.customer_id,
    a.account_type,
    a.opened_date,
    a.account_status
from "warehouse"."staging"."stg_accounts" a
  );
  