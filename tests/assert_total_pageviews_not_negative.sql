{{
    config(
        enabled=true,
        severity='error',
        tags = ['product', 'google_analytics']
    )
}}
-- Pageview aggregation should only yield positive or zero results, as a negative pageview cannot exist.
-- Return records where total pageviews is less than zero to make the test fail.
select
  source_daily_id,
  sum(pageviews) as total_pageviews
from
  {{ ref('fct_ga_source_daily') }}
group by
  1
having
  total_pageviews < 0
