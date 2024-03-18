{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH 
required_field AS (
    SELECT 
    Customer_Name,
    Province,
    Region,
    Customer_Segment,
    Cust_id
    FROM {{ source('onlineshopping','customer') }}

    WHERE Region != 'NUNAVUT'
)

SELECT * FROM required_field;