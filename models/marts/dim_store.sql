SELECT DISTINCT store_id, store_name 
FROM {{ ref('stg_store') }}