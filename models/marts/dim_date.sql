WITH calendar AS (
    SELECT
        day AS full_date
    FROM UNNEST(
        GENERATE_DATE_ARRAY('2015-01-01', '2035-12-31')
    ) AS day
)

SELECT
    CAST(FORMAT_DATE('%Y%m%d', full_date) AS INT64) AS date_id   
    ,full_date
    ,FORMAT_DATE('%A', full_date)                AS day_of_week
    ,CASE
        WHEN EXTRACT(DAYOFWEEK FROM full_date) IN (1, 7)
            THEN TRUE
        ELSE FALSE
    END                                         AS is_weekend
    ,EXTRACT(DAY FROM full_date)                  AS day_of_month
    ,DATE_TRUNC(full_date, MONTH)                 AS year_month
    ,EXTRACT(MONTH FROM full_date)                AS month
    ,EXTRACT(DAYOFYEAR FROM full_date)            AS day_of_year
    ,EXTRACT(WEEK FROM full_date)                 AS week_of_year
    ,CONCAT('Q', CAST(EXTRACT(QUARTER FROM full_date) AS STRING)) AS quarter_number
    ,DATE_TRUNC(full_date, YEAR)                  AS year
    ,EXTRACT(YEAR FROM full_date)                 AS year_number
FROM calendar
ORDER BY full_date
