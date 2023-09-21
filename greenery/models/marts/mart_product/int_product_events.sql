{{config(materialized='table')}}
with aggregation as(
SELECT 
    DATE_TRUNC('day',event_created_at) as event_day
    , product_id
    , sum(case when event_type ='add_to_cart' then 1 else 0 end) as add_to_carts
    , sum(case when event_type ='checkout' then 1 else 0 end) as checkouts
    , sum(case when event_type ='package_shipped' then 1 else 0 end) as package_shippeds
    , sum(case when event_type ='page_view' then 1 else 0 end) as page_views
FROM {{ref('stg_postgres__events')}}
GROUP BY 1,2 )

SELECT 
event_day
, product_id
, add_to_carts
, checkouts
, package_shippeds
, page_views
, checkouts/page_views AS product_daily_cvr
FROM aggregation