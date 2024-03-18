{{
    config(
        tags=['mart']
    )
}}

with
stg_market AS (
    SELECT 
    * 
    FROM {{ ref('stg_market') }}
),

stg_product AS (
    SELECT 
    * 
    FROM {{ ref('product') }}
),

cat_and_subcat AS (
    SELECT m.*,p.PRODUCT_CATEGORY,P.PRODUCT_SUB_CATEGORY
    FROM
    stg_market m
    JOIN
    stg_product p
    on
    m.Prod_id = p.PROD_ID
)

SELECT * FROM cat_and_subcat