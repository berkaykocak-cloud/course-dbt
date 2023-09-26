{{config(materialized='view')}}

SELECT
  order_id
  , product_id
  , quantity AS order_quantity
FROM {{source('postgres','order_items')}}