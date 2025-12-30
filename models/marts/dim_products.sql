WITH base_product AS (
    SELECT *
    FROM {{ ref('stg_products') }}
), 
product_unique AS(
    SELECT DISTINCT
        product_id,
        product_name,
        product_type,
        collection_name,
        category,
        category_name,
        gender
    FROM base_product
)
SELECT * FROM product_unique

