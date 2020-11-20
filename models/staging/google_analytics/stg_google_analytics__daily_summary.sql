{{
  config(
    materialized = 'view',
    )
}}

select
  _fivetran_id as daily_summary_id,
  date as report_date,
  profile,
  avg_session_duration as daily_avg_session_duration,
  avg_time_on_page as daily_avg_time_on_page,
  bounces,
  browser,
  country,
  device_category,
  language,
  medium,
  new_users,
  pageviews,
  pageviews_per_session,
  sessions,
  source,
  unique_pageviews,
  users,
  _fivetran_synced as synced_at
from
  {{ source('google_analytics', 'daily_summary') }}
