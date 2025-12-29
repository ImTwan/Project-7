SELECT DISTINCT
    SAFE_CAST(user_id_db AS INT64) AS user_id_db,
    email_address,
    device_id
FROM {{ source('glamira', 'glamira_raw') }}
