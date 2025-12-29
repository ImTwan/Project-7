SELECT DISTINCT
    ABS(
      FARM_FINGERPRINT(
          COALESCE(
              CAST(user_id_db AS STRING),
              device_id
          )
      )
    )                                   AS customer_id   -- surrogate PK (positive INT64)
  , user_id_db                          AS user_id_db
  , device_id                           AS device_id
  , email_address                       AS email_address
FROM {{ ref('stg_customers') }}
