WITH source AS (
    SELECT DISTINCT
        SAFE_CAST(store_id AS INT64) AS store_id,
        -- Create a default store_name, handle NULL store_id
        COALESCE(CONCAT('store', SAFE_CAST(store_id AS STRING)), 'Not defined') AS store_name
    FROM {{ source('glamira', 'glamira_raw') }}
),
renamed_stores AS (
    SELECT *
    FROM source
)
SELECT *
FROM renamed_stores
