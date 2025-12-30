WITH source AS (
    SELECT
        -- Convert user_id_db to STRING to allow "Not defined"
        COALESCE(NULLIF(CAST(user_id_db AS STRING), ''), 'Not defined') AS user_id_db,
        
        -- Replace NULL or empty email_address with "Not defined"
        COALESCE(NULLIF(email_address, ''), 'Not defined') AS email_address,
        
        -- Keep device_id as-is; optionally replace NULL with "Not defined"
        COALESCE(device_id, 'Not defined') AS device_id
    FROM {{ source('glamira', 'glamira_raw') }}
),
renamed_customers AS (
    SELECT *
    FROM source
)

SELECT * FROM renamed_customers