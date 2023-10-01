{{config(materialized='view')}}

{% set event_types= dbt_utils.get_column_values(table=ref('stg_postgres__events'), column='event_type') %}

WITH aggregation AS(
SELECT 
  DATE_TRUNC('day',event_created_at) AS event_day
  , COALESCE(e.product_id, oi.product_id) AS product_id
  {% for event_type in event_types %}
  , {{sum_of_categories('event_type',event_type)}} AS {{event_type}}s
  {% endfor %}
FROM {{ref('stg_postgres__events')}} e
LEFT JOIN {{ref('stg_postgres__order_items')}} oi
  ON oi.order_id=e.order_id
GROUP BY 1,2 )

SELECT 
  event_day
  , product_id
  , add_to_carts
  , checkouts
  , package_shippeds
  , page_views
  , div0(checkouts,page_views) AS product_daily_cvr
FROM aggregation