WITH source_order AS (

    -- Flatten checkout_success events
    SELECT
        SAFE_CAST(gr.order_id AS STRING) AS order_id,
        LOWER(SAFE_CAST(gr.user_id_db AS STRING)) AS user_id_db,
        SAFE_CAST(gr.email_address AS STRING) AS email_address,

        SAFE_CAST(SAFE_CAST(gr.store_id AS FLOAT64) AS INT64) AS store_id,
        gr.ip AS ip_address,

        SAFE_CAST(gr.time_stamp AS INT64) AS ts_seconds,
        SAFE.PARSE_TIMESTAMP('%Y-%m-%d %H:%M:%S', gr.local_time) AS local_time,

        cp.product_id,
        cp.currency,
        cp.price AS raw_price,
        SAFE_CAST(cp.amount AS INT64) AS quantity

    FROM {{ source('glamira', 'glamira_raw') }} gr
    CROSS JOIN UNNEST(gr.cart_products) AS cp
    WHERE gr.collection = 'checkout_success'
),

timestamps_cleaned AS (

    -- Normalize timestamps and date key
    SELECT
        *,
        TIMESTAMP_SECONDS(ts_seconds) AS order_timestamp,
        DATE(TIMESTAMP_SECONDS(ts_seconds)) AS order_date,
        SAFE_CAST(
            FORMAT_DATE('%Y%m%d', DATE(TIMESTAMP_SECONDS(ts_seconds)))
            AS INT64
        ) AS date_id
    FROM source_order
),

price_normalized AS (

    -- Normalize international price formats (STRING ONLY)
    SELECT
        *,
        CASE
            WHEN raw_price IS NULL THEN '0'

            -- 1.234,56 → 1234.56
            WHEN REGEXP_CONTAINS(raw_price, '\\.\\d{3},')
                THEN REPLACE(REPLACE(raw_price, '.', ''), ',', '.')

            -- 1234,56 → 1234.56
            WHEN REGEXP_CONTAINS(raw_price, ',\\d{2}$')
                THEN REPLACE(raw_price, ',', '.')

            -- 1,234.56 → 1234.56
            ELSE REPLACE(raw_price, ',', '')
        END AS price_string
    FROM timestamps_cleaned
),

price_cleaned AS (

    SELECT
        *,
        COALESCE(SAFE_CAST(price_string AS NUMERIC), 0) AS unit_price,
        COALESCE(quantity, 0) AS quantity_clean
    FROM price_normalized
),

order_customer_dedup AS (

    -- One customer record per order
    SELECT
        order_id,
        user_id_db,
        email_address,
        store_id,
        ip_address,
        local_time,
        order_timestamp,
        order_date,
        date_id,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY local_time
        ) AS rn

    FROM price_cleaned
),

orders AS (

    SELECT
        order_id,
        user_id_db,
        email_address,
        store_id,
        ip_address,
        local_time,
        order_timestamp,
        order_date,
        date_id
    FROM order_customer_dedup
    WHERE rn = 1
),

product_metrics AS (

    SELECT
        order_id,
        product_id,
        currency,

        SUM(quantity_clean) AS total_quantity,
        SUM(quantity_clean * unit_price) AS total_amount,
        SAFE_DIVIDE(
            SUM(quantity_clean * unit_price),
            NULLIF(SUM(quantity_clean), 0)
        ) AS avg_unit_price
    FROM price_cleaned
    GROUP BY order_id, product_id, currency
)

-- Final grain: order × product
SELECT
    o.order_id,
    o.user_id_db,
    o.email_address,
    o.store_id,
    o.ip_address,
    o.local_time,
    o.order_timestamp,
    o.order_date,
    o.date_id,

    p.product_id,
    p.currency,
    COALESCE(p.total_quantity, 0) AS quantity,
    COALESCE(p.avg_unit_price, 0) AS price,
    COALESCE(p.total_amount, 0) AS total_amount

FROM orders o
JOIN product_metrics p
    ON o.order_id = p.order_id
