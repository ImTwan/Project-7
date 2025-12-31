WITH base_loc AS (
    SELECT DISTINCT
        country_name,
        region_name,
        city_name
    FROM {{ ref('stg_location') }}
)

SELECT
    CAST(
        ABS(
            FARM_FINGERPRINT(
                CONCAT(
                    COALESCE(country_name, ''), '|',
                    COALESCE(region_name, ''), '|',
                    COALESCE(city_name, '')
                )
            )
        ) AS INT64
    ) AS location_id,
    country_name,
    region_name,
    city_name
FROM base_loc
