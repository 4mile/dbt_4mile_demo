{{
  config(
    materialized = 'view',
    )
}}

select
  generate_uuid() as iris_id,
  species,
  sepal_length,
  sepal_width,
  petal_length,
  petal_width
from
  {{ source('public', 'iris_ml_data')}}
