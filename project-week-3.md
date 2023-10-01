# Project Week 3 Questions

## PART 1. Create a new model

**Question 1:** What is our overall conversion rate?

**Answer 1:** Our overall conversion rate is 62.46%.

**SQL:**
```
SELECT 
COUNT(DISTINCT CASE WHEN checkouts>0 THEN session_id END) AS conversions
, COUNT(DISTINCT session_id) AS sessions
, conversions/sessions AS conversion_rate
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.FACT_PAGE_VIEWS
```

**Question 2:** What is our conversion rate by product?

**Answer 2:** The conversion rate per product can be found using the following SQL query.

**SQL:**
```
SELECT
page_views.product_id
, product_name
, COUNT(DISTINCT CASE WHEN checkouts>0 THEN session_id END) AS conversions
, COUNT(DISTINCT session_id) AS sessions
, conversions/sessions AS conversion_rate
FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.FACT_PAGE_VIEWS AS page_views
LEFT JOIN DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.STG_POSTGRES__PRODUCTS AS products
  ON page_views.product_id=products.product_id
GROUP BY 1,2
```

## PART 6. dbt Snapshots

**Question 3:** Which products had their inventory change from week 1 to week 2?

**Answer 3:** The inventory for the following product ids have changed from week 1 to week 2: 
be49171b-9f72-4fc9-bf7a-9a52e259836b, fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80, 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3
,4cda01b9-62e2-46c5-830f-b7f262a58fb1, 689fb64e-a4a2-45c5-b9f2-480c2155624d, b66a7143-c18a-43bb-b5dc-06bb5d1d3160

**SQL:**
```
SELECT * FROM DEV_DB.DBT_KOCAKBERKAYYGMAILCOM.PRODUCTS_SNAPSHOT WHERE DBT_VALID_TO IS NOT NULL
```