SELECT
  SAFE_CAST(r.order_id AS INT64) AS order_id,
  SAFE_CAST(cp.product_id AS INT64) AS product_id,
  SAFE_CAST(r.store_id AS INT64) AS store_id,
  SAFE_CAST(r.user_id_db AS INT64) AS user_id_db,
  r.device_id AS device_id,
  r.ip AS ip_address,
  TIMESTAMP_SECONDS(r.time_stamp) AS time_stamp,
  TIMESTAMP_SECONDS(r.time_stamp) AS local_time,
  DATE(TIMESTAMP_SECONDS(r.time_stamp)) AS full_date,
  SAFE_CAST(cp.amount AS INT64) AS quantity,
  COALESCE(cp.currency, r.currency) AS currency, 
  SAFE_CAST(REPLACE(cp.price, ',', '.') AS NUMERIC) AS price,
  SAFE_CAST(cp.amount AS NUMERIC) * SAFE_CAST(REPLACE(cp.price, ',', '.') AS NUMERIC) AS amount
FROM {{ source('glamira', 'glamira_raw') }} AS r
CROSS JOIN UNNEST(r.cart_products) AS cp
WHERE r.collection = 'checkout_success'
