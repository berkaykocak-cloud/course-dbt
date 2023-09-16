{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','promos')}}
)

, renamed_recast as(
    select
    promo_id AS promotion_id
    , discount AS promotion_discount
    , status AS promotion_status
    from source
)

SELECT * FROM renamed_recast