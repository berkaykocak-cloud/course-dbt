Question 1: How many users do we have?

Answer 1: We have 130 users.

SQL:
```
SELECT COUNT(*) 
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__USERS
```

Question 2: On average, how many orders do we receive per hour?

Answer 2: We receive 7.52 orders per hour on average. 

SQL:
```
WITH orders AS (
SELECT 
DATE_TRUNC('hour',created_at) as order_hour
, COUNT(DISTINCT ORDER_ID) AS number_of_orders
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__ORDERS
GROUP BY 1
ORDER BY 1
)
SELECT AVG(number_of_orders) AS average_orders FROM orders 
```

Question 3: On average, how long does an order take from being placed to being delivered?

Answer 3: It takes 93.4 hours to be delivered for an order on average.

SQL:
```
SELECT AVG(DATEDIFF(hour, created_at::DATE, delivered_at::DATE)) FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__ORDERS
```

Question 4: How many users have only made one purchase? Two purchases? Three+ purchases?

Answer 4: 25 users made 1 purchase. 28 users made 2 purchases. 71 users made 3+ purchases.

SQL:
```
WITH users_purchases AS(
SELECT USER_ID, COUNT(DISTINCT ORDER_ID) AS NUMBER_OF_PURCHASES FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__ORDERS
GROUP BY 1
ORDER BY 2 DESC
)
SELECT 
COUNT(DISTINCT CASE WHEN NUMBER_OF_PURCHASES=1 THEN USER_ID END) AS USERS_WITH_ONE_PURCHASE
,COUNT(DISTINCT CASE WHEN NUMBER_OF_PURCHASES=2 THEN USER_ID END) AS USERS_WITH_TWO_PURCHASE
,COUNT(DISTINCT CASE WHEN NUMBER_OF_PURCHASES>=3 THEN USER_ID END) AS USERS_WITH_MORE_THAN_THREE_PURCHASE
from users_purchases
```

Question 5: On average, how many unique sessions do we have per hour?

Answer 5: We have 16.33 sessions per hour on average. 

SQL:
```
WITH sessions AS (
SELECT 
DATE_TRUNC('hour',created_at) as session_hour
, COUNT(DISTINCT SESSION_ID) AS number_of_sessions
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__EVENTS
GROUP BY 1
ORDER BY 1
)
SELECT AVG(number_of_sessions) AS average_sessions FROM sessions 
```