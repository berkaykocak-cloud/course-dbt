{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','order_items')}}
)

, renamed_recast as(
    select
    order_id
    , product_id
    , quantity AS order_quantity
    from source
)

SELECT * FROM renamed_recast