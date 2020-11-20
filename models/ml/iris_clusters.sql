{{
  config(
    ml_config={
      'model_type': 'kmeans',
      'num_clusters': 4,
      'standardize_features': true
    }
  )
}}

select
  sepal_length,
  sepal_width,
  petal_length,
  petal_width,
from
  {{ ref('stg_public_data__iris') }}
