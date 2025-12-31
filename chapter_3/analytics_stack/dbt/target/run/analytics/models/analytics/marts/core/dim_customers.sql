
  
    

  create  table "warehouse"."analytics"."dim_customers__dbt_tmp"
  
  
    as
  
  (
    select
    customer_id,
    first_name,
    last_name,
    province_code,
    customer_since
from "warehouse"."staging"."stg_customers"
  );
  