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

stg_shipping AS (
    SELECT 
    * 
    FROM {{ ref('stg_shipping') }}
),

ship_date_difference AS (
    SELECT 
    c.Customer_Name,
    c.Cust_id,
    o.Ord_id,
    o.Order_Priority,
    m.Prod_id,
    m.Ship_id,
    m.Shipping_Cost,
    o.Order_date,
    s.Ship_date,
    s.ship_mode,
    datediff(DAY,o.Order_date,s.Ship_Date) as difference_in_days,
    (CASE WHEN (o.Order_Priority = 'HIGH' OR o.Order_Priority = 'CRITICAL') AND datediff(DAY, o.Order_date, s.Ship_Date) > 3 THEN 'True' ELSE 'False' END) AS Need_support
    FROM
    stg_customers c
    JOIN
    stg_market m
    ON m.Cust_id = c.Cust_id
    JOIN
    stg_order o
    ON o.Ord_id = m.Ord_id
    JOIN
    stg_shipping s
    ON s.Ship_id = m.Ship_id
)

SELECT * FROM ship_date_difference;