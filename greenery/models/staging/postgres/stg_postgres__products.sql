{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','products')}}
)

, renamed_recast as(
    select
    product_id
    , name AS product_name
    , price AS product_price
    , inventory AS product_inventory
    from source
)

SELECT * FROM renamed_recast