{{config(materialized='table')}}

WITH aggregation AS(
SELECT 
  DATE_TRUNC('day',event_created_at) AS event_day
  , product_id
  , SUM(CASE WHEN event_type ='add_to_cart' THEN 1 ELSE 0 END) AS add_to_carts
  , SUM(CASE WHEN event_type ='checkout' THEN 1 ELSE 0 END) AS checkouts
  , SUM(CASE WHEN event_type ='package_shipped' THEN 1 ELSE 0 END) AS package_shippeds
  , SUM(CASE WHEN event_type ='page_view' THEN 1 ELSE 0 END) AS page_views
FROM {{ref('stg_postgres__events')}}
GROUP BY 1,2 )

SELECT 
  event_day
  , product_id
  , add_to_carts
  , checkouts
  , package_shippeds
  , page_views
  , div0(checkouts,page_views) AS product_daily_cvr
FROM aggregation