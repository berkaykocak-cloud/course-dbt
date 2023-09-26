{{config(materialized='view')}}

SELECT
  created_at AS event_created_at
  , event_id
  , event_type
  , order_id
  , page_url
  , product_id
  , session_id
  , user_id
FROM {{source('postgres','events')}}