SELECT DISTINCT
    ip,
    country AS country_name,
    region AS region_name,
    city AS city_name
FROM {{ source('glamira', 'ip_locations') }}
