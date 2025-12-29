SELECT DISTINCT
    SAFE_CAST(store_id AS INT64) AS store_id,
    CONCAT('store', store_id) AS store_name
FROM {{ source('glamira', 'glamira_raw') }}
