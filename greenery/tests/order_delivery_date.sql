SELECT *
FROM {{ ref('stg_postgres__orders') }}
WHERE order_delivered_at < order_created_at 
/* checking if there are any instances where the delivery date is before the date the order was placed which 
wouldn't make sense logically and indicate some sort of data issue */