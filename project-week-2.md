# Project Week 2 Questions

## PART 1. Models

**Question 1:** What is our user repeat rate?

**Answer 1:** Our user repeat rate is 79.84%.

**SQL:**
```
WITH users_purchases AS(
SELECT USER_ID, COUNT(DISTINCT ORDER_ID) AS NUMBER_OF_PURCHASES FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__ORDERS
GROUP BY 1
ORDER BY 2 DESC
)

SELECT 
COUNT(DISTINCT CASE WHEN NUMBER_OF_PURCHASES=1 THEN USER_ID END) AS USERS_WITH_ONE_PURCHASE
,COUNT(DISTINCT CASE WHEN NUMBER_OF_PURCHASES>=2 THEN USER_ID END) AS USERS_WITH_MORE_THAN_ONE_PURCHASE
,COUNT(DISTINCT USER_ID) AS USERS_WITH_PURCHASES
,div0(USERS_WITH_MORE_THAN_ONE_PURCHASE,USERS_WITH_PURCHASES) AS REPEAT_RATE
from users_purchases
```

**Question 2:** What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

**Answer 2:**  I would start with the orders and users table to analyse the features of users and orders. Most important feature in my opinion is whether the user have made a purchase before and they are satisfied with the purchase. If we have the returned item data that might also contribute to our analyses. In addition, active users that interact with our website and pages, creating sessions are more likely to buy than those who do not.  Users that created multiple orders before are again more likely to buy. 

On the other hand, the users that do not interact with the website, that do not have previous purchases are not likely to buy. If we again had returned orders data, the users that returned a high percentage of the products that they bought might also be likely to not order again.

**Question 3:** Explain the product mart models you added. Why did you organize the models in the way you did?

**Answer 3:** I have added one intermediate and one fact layer in my mart_product folder. The intermediate model int_product_events some heavy calculations are made to count distinct events per product on a daily basis. These events include page_views, add_to_carts, checkouts and package_shippeds. On the fact_product_events layer the events events from the intermediate layer have been enriched with data from other tables. The additional data includes product_name and product_price.

## PART 2. Tests

**Question 4:** What assumptions are you making about each model? (i.e. why are you adding each test?)

**Answer 4:** I mainly applied tests to test for not null and uniqueness of the primary keys of the table. In addition to this I applied accepted values tests for categorical values. Finally I applied positive values tests when I saw fit in Greenery dataset. 

**Question 5:** Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

**Answer 5:** All the tests have passed, therefore there was no bad data detected until now.

**Question 6:** Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.

**Answer 6:** I would set up a slack channel about dbt alerts. I would let the stakeholders know about the assumptions and tests I am making about the data taking also their input. Then in this slack channel I would alert the stakeholders whenever a rule is breached.

## PART 3. dbt Snapshots

**Question 7:** Which products had their inventory change from week 1 to week 2?

**Answer 7:** The inventory for the following product ids have changed from week 1 to week 2: 
4cda01b9-62e2-46c5-830f-b7f262a58fb1, 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3, be49171b-9f72-4fc9-bf7a-9a52e259836b, fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80

**SQL:**
```
SELECT * FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.PRODUCTS_SNAPSHOT WHERE DBT_VALID_TO IS NOT NULL
```