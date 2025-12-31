WITH source AS (
    SELECT
        COALESCE(NULLIF(CAST(user_id_db AS STRING), ''), 'Not defined') AS user_id_db,
        COALESCE(NULLIF(email_address, ''), 'Not defined') AS email_address
    FROM {{ source('glamira', 'glamira_raw') }}
)

SELECT *
FROM source
