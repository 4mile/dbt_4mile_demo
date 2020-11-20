{{
  config(
    materialized = 'table',
    )
}}

select
  farm_fingerprint({{ dbt_utils.surrogate_key(['report_date', 'source', 'medium', 'browser']) }}) as source_daily_id,
  report_date as visit_date,
  source,
  medium,
  browser,
  avg(daily_avg_session_duration) as daily_avg_session_duration,
  avg(daily_avg_time_on_page) as daily_avg_time_on_page,
  sum(bounces) as bounces,
  sum(new_users) as new_users,
  sum(pageviews) as pageviews,
  avg(pageviews_per_session) as daily_avg_pageviews_per_session,
  sum(sessions) as sessions,
  sum(unique_pageviews) as unique_pageviews,
  sum(users) as users
from
  {{ ref('stg_google_analytics__daily_summary') }}
group by
  2, 3, 4, 5