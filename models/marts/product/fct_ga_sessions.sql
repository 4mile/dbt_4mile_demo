{{
  config(
    materialized = 'table',
    )
}}

select
  case
    when medium = 'Google' then 1
    when medium = 'Facebook' then 1
    when medium = '(Direct)' then 0
    else 0
  end as is_paid_medium
from
  {{ ref('fct_ga_source_daily')} }
