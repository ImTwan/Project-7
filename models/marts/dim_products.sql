SELECT 
    product_id,
    product_name, 
    product_type,
    collection_id,
    collection_name,
    category,
    category_name,
    gender
FROM {{ ref('stg_products') }}
    
