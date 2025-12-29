SELECT
    SAFE_CAST(product_id AS INT64) AS product_id,
    name AS product_name, 
    product_type,
    SAFE_CAST(collection_id AS INT64) AS collection_id,
    collection AS collection_name,
    category,
    category_name,
    gender
FROM {{ source('glamira', 'crawl_product') }}
