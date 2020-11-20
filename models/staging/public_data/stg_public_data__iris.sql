{{
  config(
    materialized = 'view',
    )
}}

select
  farm_fingerprint({{ dbt_utils.surrogate_key(['species', 'sepal_length', 'sepal_width', 'petal_length', 'petal_width']) }}) as iris_id,
  species,
  sepal_length,
  sepal_width,
  petal_length,
  petal_width
from
  {{ source('public', 'iris_ml_data')}}
