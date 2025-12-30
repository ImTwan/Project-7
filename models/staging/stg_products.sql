WITH source AS (
    SELECT
        SAFE_CAST(product_id AS INT64) AS product_id,
        name AS product_name, 
        product_type,
        collection AS collection_name,
        category,
        category_name,
        gender
    FROM {{ source('glamira', 'crawl_product') }}
), 
product_cleaned AS (
    SELECT
        product_id,
        -- Handle NULL or empty strings
        COALESCE(NULLIF(product_name, ''), 'Not defined') AS product_name,
        COALESCE(NULLIF(product_type, ''), 'Not defined') AS product_type,
        COALESCE(NULLIF(collection_name, ''), 'Not defined') AS collection_name,
        COALESCE(NULLIF(category, ''), 'Not defined') AS category,
        COALESCE(NULLIF(category_name, ''), 'Not defined') AS category_name,
        COALESCE(NULLIF(gender, ''), 'Not defined') AS gender
    FROM source
)
SELECT * FROM product_cleaned
