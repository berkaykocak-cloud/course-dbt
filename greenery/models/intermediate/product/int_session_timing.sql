{{config(materialized='view')}}

SELECT
  session_id
  , min(event_created_at) as session_started_at
  , max(event_created_at) as session_ended_at
FROM {{ref('stg_postgres__events')}}
GROUP BY 1