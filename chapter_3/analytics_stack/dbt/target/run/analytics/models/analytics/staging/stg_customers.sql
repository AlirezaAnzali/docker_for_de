
  create view "warehouse"."staging"."stg_customers__dbt_tmp"
    
    
  as (
    with src as (

    select * from "warehouse"."raw"."customers"

),

deduped as (

    select distinct on (cust_id)
        cust_id as customer_id,
        split_part(full_name, ' ', 1) as first_name,
        split_part(full_name, ' ', 2) as last_name,
        case
            when lower(province) in ('ontario', 'on') then 'ON'
            when lower(province) in ('bc', 'british columbia') then 'BC'
            when lower(province) = 'qc' then 'QC'
            when lower(province) = 'ab' then 'AB'
            else 'UNKNOWN'
        end as province_code,
        signup_dt
    from src
    order by cust_id, signup_dt

)

select
    customer_id,
    first_name,
    last_name,
    province_code,
    case
        when signup_dt ~ '^\d{4}-\d{2}-\d{2}$'
            then signup_dt::date
        when signup_dt ~ '^\d{2}-\d{2}-\d{4}$'
            then to_date(signup_dt, 'MM-DD-YYYY')
        when signup_dt ~ '^\d{2}/\d{2}/\d{4}$'
            then to_date(signup_dt, 'MM/DD/YYYY')
        when signup_dt ~ '^\d{4}/\d{2}/\d{2}$'
            then to_date(signup_dt, 'YYYY/MM/DD')
        when signup_dt ~ '^\d{4}\.\d{2}\.\d{2}$'
            then to_date(signup_dt, 'YYYY.MM.DD')
        else null
    end as customer_since
from deduped
  );