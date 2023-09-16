{% snapshot products_snapshot %}

{{
  config(
    target_database = target.database,
    target_schema = target.schema,
    strategy='check',
    unique_key='product_id',
    check_cols=['product_inventory'],
   )
}}

  SELECT 
    product_id
    , name AS product_name
    , price AS product_price
    , inventory AS product_inventory
  FROM {{ source('postgres', 'products') }}

{% endsnapshot %}