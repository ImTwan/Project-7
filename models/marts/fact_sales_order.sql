SELECT
    -- Fact surrogate key
    ABS(
      FARM_FINGERPRINT(
        CONCAT(
          COALESCE(l.country_name, ''), '|',
          COALESCE(l.region_name, ''), '|',
          COALESCE(l.city_name, '')
        )
      )
    ) AS SK_Fact_Sales,

    s.order_id,

    -- Customer key (already hashed in dim_customers, make it positive)
    ABS(
      FARM_FINGERPRINT(
          COALESCE(
              CAST(c.user_id_db AS STRING),
              c.device_id
          )
      )
    )                                   AS customer_id,
    s.product_id,
    d.date_id,

    -- Location key
    ABS(
      FARM_FINGERPRINT(
        CONCAT(
          COALESCE(l.country_name, ''), '|',
          COALESCE(l.region_name, ''), '|',
          COALESCE(l.city_name, '')
        )
      )
    ) AS location_id,

    s.ip_address,
    s.user_id_db,
    s.store_id,
    s.local_time,
    s.time_stamp,
    s.quantity,
    s.currency,
    s.price,
    s.amount

FROM {{ ref('stg_sales_order') }} s

LEFT JOIN {{ ref('dim_location') }} l
  ON s.ip_address = l.ip_address

LEFT JOIN {{ ref('dim_date') }} d
  ON s.full_date = d.full_date

LEFT JOIN {{ ref('dim_products') }} p
  ON s.product_id = p.product_id

LEFT JOIN {{ ref('dim_store') }} st
  ON s.store_id = st.store_id

LEFT JOIN {{ ref('dim_customers') }} c
  ON s.user_id_db = c.user_id_db
