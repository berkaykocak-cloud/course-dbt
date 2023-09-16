{{config(materialized='view')}}

with source as(
    select * from {{source('postgres','events')}}
)

, renamed_recast as(
    select
    created_at AS event_created_at
    , event_id
    , event_type
    , order_id
    , page_url
    , product_id
    , session_id
    , user_id
    from source
)

SELECT * FROM renamed_recast