{{config(materialized='view')}}

SELECT
  address
  , address_id
  , country
  , state
  , zipcode
FROM {{source('postgres','addresses')}}