{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','products')}}
)

, renamed_recast as(
    select
    product_id
    , name
    , price
    , inventory
    from source
)

SELECT * FROM renamed_recast