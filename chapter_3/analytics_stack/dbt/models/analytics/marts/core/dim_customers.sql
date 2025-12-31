select
    customer_id,
    first_name,
    last_name,
    province_code,
    customer_since
from {{ ref('stg_customers') }}