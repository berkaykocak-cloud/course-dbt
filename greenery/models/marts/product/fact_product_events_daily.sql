{{config(materialized='table')}}

WITH product_events AS(
SELECT 
  event_day
  , product_id
  , add_to_carts
  , checkouts
  , package_shippeds
  , page_views
  , product_daily_cvr
FROM {{ref('int_product_events')}}
)

, product_details AS(
SELECT
  product_id
  , product_name
  , product_price
FROM {{ref('stg_postgres__products')}}
)

SELECT
  product_events.event_day
  , product_details.product_name
  , product_details.product_price
  , product_events.product_id
  , product_events.add_to_carts
  , product_events.checkouts
  , product_events.package_shippeds
  , product_events.page_views
  , product_events.product_daily_cvr
FROM product_events
LEFT JOIN product_details ON product_events.product_id= product_details.product_id
