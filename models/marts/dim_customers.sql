WITH base_customers AS (
    SELECT
        COALESCE(NULLIF(user_id_db, ''), 'Not defined') AS user_id_db,
        COALESCE(NULLIF(email_address, ''), 'Not defined') AS email_address
    FROM {{ ref('stg_customers') }}
),
customers_unique AS(
    SELECT DISTINCT
    -- Surrogate PK using both user_id_db and device_id to guarantee uniqueness
    CAST(
            ABS(
                FARM_FINGERPRINT(
                    CONCAT(user_id_db, '|', email_address)
                )
            ) AS INT64
        ) AS customer_id,
    
    user_id_db,
    email_address
FROM base_customers
WHERE user_id_db IS NOT NULL AND email_address IS NOT NULL
)
SELECT * FROM customers_unique

