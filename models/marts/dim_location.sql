SELECT DISTINCT
    ABS(
        FARM_FINGERPRINT(
            CONCAT(
                COALESCE(country_name, ''), '|',
                COALESCE(region_name, ''), '|',
                COALESCE(city_name, '')
            )
        )
    ) AS location_id,   -- PK 
    ip AS ip_address,                 -- natural key 
    country_name,
    region_name,
    city_name
FROM {{ ref('stg_location') }}
