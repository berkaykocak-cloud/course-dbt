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

,  product_details AS(

SELECT
    product_id
    , product_name
    , product_price
FROM {{ref('stg_postgres__products')}}
)


SELECT