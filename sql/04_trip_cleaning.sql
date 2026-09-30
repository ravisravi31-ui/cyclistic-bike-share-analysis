-- Create the analysis-ready 2019 trip table from raw staging data.
-- Source fields that may contain blanks/non-standard values are cleaned
-- during transformation rather than modifying the raw staging table.

CREATE TABLE trips_2019 AS
SELECT
    trip_id,

    STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s') AS start_time,
    STR_TO_DATE(end_time, '%Y-%m-%d %H:%i:%s') AS end_time,

    CASE
        WHEN CAST(REPLACE(tripduration, ',', '') AS DECIMAL(12,2)) <= 86400
        THEN ROUND(
            CAST(REPLACE(tripduration, ',', '') AS DECIMAL(12,2)) / 60,
            2
        )
        ELSE NULL
    END AS ride_length_minutes,

    from_station_id,
    to_station_id,

    CASE
        WHEN usertype = 'Subscriber' THEN 'Member'
        WHEN usertype = 'Customer' THEN 'Casual'
        ELSE usertype
    END AS member_casual,

    gender,

    CASE
        WHEN TRIM(birthyear) = '' THEN NULL
        WHEN CAST(REPLACE(birthyear, ',', '') AS DECIMAL(6,1)) < 1900 THEN NULL
        ELSE CAST(REPLACE(birthyear, ',', '') AS DECIMAL(6,1))
    END AS birthyear,

    period,

    DAYNAME(STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s')) AS day_of_week,

    HOUR(STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s')) AS hour,

    MONTH(STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s')) AS month,

    QUARTER(STR_TO_DATE(start_time, '%Y-%m-%d %H:%i:%s')) AS quarter,

    CASE
        WHEN TRIM(birthyear) = '' THEN NULL
        WHEN CAST(REPLACE(birthyear, ',', '') AS DECIMAL(6,1)) < 1900 THEN NULL
        ELSE 2019 - CAST(REPLACE(birthyear, ',', '') AS DECIMAL(6,1))
    END AS age

FROM trips_2019_staging;
