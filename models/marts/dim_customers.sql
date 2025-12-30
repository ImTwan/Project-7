WITH base_customers AS (
    SELECT *
    FROM {{ ref('stg_customers') }}
),
customers_unique AS(
    SELECT DISTINCT
    -- Surrogate PK using both user_id_db and device_id to guarantee uniqueness
    ABS(
        FARM_FINGERPRINT(
            CONCAT(user_id_db, '_', device_id)
        )
    ) AS customer_id,
    
    user_id_db,
    device_id,
    email_address
FROM base_customers
)
SELECT * FROM customers_unique

