{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH 
required_field AS (
    SELECT 
    CAST(Order_ID AS FLOAT) AS Order_ID,
    CONVERT(datetime,Order_Date,105) AS Order_Date,
    Order_Priority,
    Ord_id
    FROM {{ source('onlineshopping','order') }}
)

SELECT * FROM required_field;