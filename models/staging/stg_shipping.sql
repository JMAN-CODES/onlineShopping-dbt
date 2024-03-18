{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH 
required_field AS (
    SELECT 
    CAST(Order_ID AS INT) AS Order_ID,
    CONVERT(datetime,Ship_date,105) AS Ship_Date,
    Ship_Mode,
    Ship_id
    FROM {{ source('onlineshopping','shipping') }}
)
SELECT * FROM required_field;