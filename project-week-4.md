# Project Week 4 Questions

## PART 1. dbt Snapshots

**Question 1:** Which products had their inventory change from week 3 to week 4?

**Answer 1:** The inventory for the following product ids have changed from week 3 to week 4: 
be49171b-9f72-4fc9-bf7a-9a52e259836b, fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80, 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3
,4cda01b9-62e2-46c5-830f-b7f262a58fb1, 689fb64e-a4a2-45c5-b9f2-480c2155624d, b66a7143-c18a-43bb-b5dc-06bb5d1d3160
These are the same products where there was a change in inventory in the past weeks so it is fair to say that these
6 products have the most fluctuations in their stock. 

2 of these products gone out of stock in the last week. The product ids are as follows:
fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80, 4cda01b9-62e2-46c5-830f-b7f262a58fb1

**SQL:**
```
SELECT * FROM DBT_KOCAKBERKAYYGMAILCOM.PRODUCTS_SNAPSHOT WHERE DBT_VALID_FROM > '2023-10-02'
```

## PART 2. Modelling Challange

**Question 2:** How are our users moving through the product funnel?

**Answer 2:** There are 4 steps that define the product funnel that the Greenery offers according to the tracking events. The users view a page, they add a product to the cart, they do the checkout and the package is shipped to them in the end.

**Question 3:** Which steps in the funnel have largest drop off points?

**Answer 3:** The percentages of the users that follow each step of the funnel in comparison to the sessions are as follows: 
page_view_percentage: 100%
add_to_cart_percentage: 80.80%
checkout_percentage: 62.46%
package_shipped_percentage: 57.96%

According to this analysis, the largest dropoff points of the funnel seem to be add_to_cart from page_view and checkout from add_to_cart. All of the users that created a session have a page view, and a big majority of customers who did a checkout received their package. 

BONUS: The product funnel: https://app.sigmacomputing.com/corise-dbt/workbook/Product-Funnel-5ATs6swIb7aO5Awwmhuk1g

**SQL:**
```
WITH numbers as(
SELECT 
COUNT(DISTINCT session_id) AS sessions
, COUNT(DISTINCT CASE WHEN page_views>0 THEN session_id END) AS page_views
, COUNT(DISTINCT CASE WHEN add_to_carts>0 THEN session_id END) AS add_to_carts
, COUNT(DISTINCT CASE WHEN checkouts>0 THEN session_id END) AS conversions
, COUNT(DISTINCT CASE WHEN package_shippeds>0 THEN session_id END) AS package_shippeds
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.FACT_PAGE_VIEWS
)

SELECT 
*
, page_views*100/sessions AS page_view_percentage
, add_to_carts*100/sessions AS add_to_cart_percentage
, conversions*100/sessions AS conversion_percentage
, package_shippeds*100/sessions AS package_shipped_percentage
FROM numbers
```

## PART 3. Reflection Questions

**Question 3A:** dbt next steps for you 
Reflecting on your learning in this class if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?

**Answer 3A:** 
I was already using dbt in my current job but with this course I developed data points beginning from the source for the first time which was really fun. I learned more about macros, jinjas, snapshots and artifacts which I am sure will be helpful in my career.

**Question 3B:** Setting up for production / scheduled dbt run of your project And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state? You don’t have to actually set anything up - just jot down what you would do and why and post in a README file.

Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc.

**Answer 3B:** I would use Airflow for orchestration since I already have some familiarity and I would have dbt snapshot, dbt run, dbt test (possibly together as dbt build so that if a run fails I do not run downstream models), dbt snapshot as some steps. I would try to run the models minimum daily and have full refresh on the weekends. 