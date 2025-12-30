WITH base_store AS (
    SELECT *
    FROM {{ ref('stg_store') }}
)
SELECT DISTINCT *
FROM base_store
