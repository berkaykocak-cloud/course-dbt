{{config(materialized='view')}}

SELECT
  promo_id AS promotion_id
  , discount AS promotion_discount
  , status AS promotion_status
FROM {{source('postgres','promos')}}