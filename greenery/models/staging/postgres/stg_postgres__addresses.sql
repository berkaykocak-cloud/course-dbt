{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','addresses')}}
)

, renamed_recast as(
    select
    address
    , address_id
    , country
    , state
    , zipcode
    from source
)

SELECT * FROM renamed_recast