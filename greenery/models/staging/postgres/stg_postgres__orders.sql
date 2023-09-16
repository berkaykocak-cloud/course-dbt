{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','orders')}}
)

, renamed_recast as(
    select
    address_id
    , created_at AS order_created_at
    , delivered_at AS order_delivered_at
    , estimated_delivery_at AS order_estimated_delivery_at
    , order_cost
    , order_id
    , order_total
    , promo_id AS promotion_id
    , shipping_cost AS order_shipping_cost
    , shipping_service AS order_shipping_service
    , status AS order_status
    , tracking_id AS order_tracking_id
    , user_id
    from source
)

SELECT * FROM renamed_recast