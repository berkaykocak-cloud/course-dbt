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