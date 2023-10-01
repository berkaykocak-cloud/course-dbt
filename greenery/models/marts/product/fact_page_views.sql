
{{
  config(
    materialized='table'
    , post_hook= "{{ grant('reporting')}}"
    )
}}

WITH session_timing_agg AS (
SELECT *
FROM {{ref('int_session_timing')}}
)

{% set event_types= dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type') %}

SELECT
  e.session_id
  , e.user_id
  , COALESCE(e.product_id, oi.product_id) AS product_id
  , s.session_started_at
  , s.session_ended_at
  {% for event_type in event_types %}
  , {{sum_of_categories('e.event_type',event_type)}} AS {{event_type}}s
  {% endfor %}
  , datediff('minute', s.session_started_at, s.session_ended_at) AS session_length_minutes
FROM {{ref('stg_postgres__events')}} e
LEFT JOIN {{ref('stg_postgres__order_items')}} oi
  ON oi.order_id=e.order_id
LEFT JOIN session_timing_agg s
  ON s.session_id=e.session_id
GROUP BY 1,2,3,4,5