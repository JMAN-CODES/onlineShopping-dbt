{{
    config(
        tags=['mart']
    )
}}

with 
stg_customers AS (
    SELECT 
    * 
    FROM {{ ref('stg_customers') }}
),

stg_market AS (
    SELECT 
    * 
    FROM {{ ref('stg_market') }}
),

stg_order AS (
    SELECT 
    * 
    FROM {{ ref('stg_order') }}
),

customer_detail AS (
    SELECT c.Customer_Name,
    m.Cust_id,MAX(Order_Date) as most_recent_date,
    MIN(Order_date)first_ordered_date,
    sum(Sales) as Lifetime_Ordered_Value,
    count(*) as total_orders
    FROM
    stg_customers c
    JOIN
    stg_market M
    ON m.Cust_id = c.Cust_id
    JOIN
    stg_order o
    ON o.Ord_id = m.Ord_id
    group by m.Cust_id,c.Customer_Name
)

SELECT * FROM customer_detail;