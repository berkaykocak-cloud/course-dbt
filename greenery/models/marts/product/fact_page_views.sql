
{{config(materialized='table')}}

WITH session_timing_agg AS (
SELECT *
FROM {{ref('int_session_timing')}}
)

SELECT
  e.session_id
  , e.user_id
  , COALESCE(e.product_id, oi.product_id) AS product_id
  , s.session_started_at
  , s.session_ended_at
  , SUM(CASE WHEN e.event_type ='add_to_cart' THEN 1 ELSE 0 END) AS add_to_carts
  , SUM(CASE WHEN e.event_type ='checkout' THEN 1 ELSE 0 END) AS checkouts
  , SUM(CASE WHEN e.event_type ='package_shipped' THEN 1 ELSE 0 END) AS package_shippeds
  , SUM(CASE WHEN e.event_type ='page_view' THEN 1 ELSE 0 END) AS page_views
  , datediff('minute', s.session_started_at, s.session_ended_at) AS session_length_minutes
FROM {{ref('stg_postgres__events')}} e
LEFT JOIN {{ref('stg_postgres__order_items')}} oi
  ON oi.order_id=e.order_id
LEFT JOIN session_timing_agg s
  ON s.session_id=e.session_id
GROUP BY 1,2,3,4,5