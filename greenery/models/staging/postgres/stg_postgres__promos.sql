{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','promos')}}
)

, renamed_recast as(
    select
    promo_id
    , discount
    , status
    from source
)

SELECT * FROM renamed_recast