{{
    config(
        tags=['mart']
    )
}}

WITH
stg_market AS (
    SELECT 
    * 
    FROM {{ ref('stg_market') }}
),

profit_loss AS (
    SELECT SUM(Profit) as net_profit, Ord_id
    FROM stg_market
    GROUP BY Ord_id
)

SELECT * FROM profit_loss