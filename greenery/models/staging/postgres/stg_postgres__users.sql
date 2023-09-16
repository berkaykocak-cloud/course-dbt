{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','users')}}
)

, renamed_recast as(
    select
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at AS user_created_at
    , updated_at AS user_updated_at
    , address_id
    from source
)

SELECT * FROM renamed_recast