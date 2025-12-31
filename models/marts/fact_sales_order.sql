WITH base_order AS (
    SELECT *
    FROM {{ ref('stg_sales_order') }}
),


order_final AS (
    SELECT 
        CAST(
            ABS(
                FARM_FINGERPRINT(
                    CONCAT(
                        CAST(bo.order_id AS STRING), '_',
                        CAST(bo.product_id AS STRING)
                    )
                )
            ) AS INT64
        ) AS SK_Fact_Sales,
        bo.order_id,
        dp.product_id,
        bo.date_id,
        dl.location_id,
        bo.ip_address,
        dc.customer_id,
        ds.store_id,
        bo.local_time,
        bo.order_timestamp,
        bo.quantity,
        bo.currency,
        bo.price,
        bo.total_amount

        FROM base_order bo

    LEFT JOIN {{ ref('dim_products') }} dp
        ON bo.product_id = dp.product_id

    LEFT JOIN {{ ref('dim_date') }} d
        ON bo.date_id = d.date_id

    LEFT JOIN {{ ref('dim_customers') }} dc
        ON bo.user_id_db = dc.user_id_db
       AND bo.device_id = dc.device_id

    LEFT JOIN {{ ref('dim_store') }} ds
        ON bo.store_id = ds.store_id

    LEFT JOIN {{ ref('stg_location') }} l
        ON bo.ip_address = l.ip

    LEFT JOIN {{ ref('dim_location') }} dl
        ON l.country_name = dl.country_name
       AND l.region_name  = dl.region_name
       AND l.city_name    = dl.city_name
)

SELECT * FROM order_final
