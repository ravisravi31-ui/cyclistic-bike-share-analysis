USE divvy_analysis;

CREATE TABLE summary_user_type AS
SELECT
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY member_casual;

CREATE TABLE summary_day_user AS
SELECT
    day_of_week,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY day_of_week, member_casual;

CREATE TABLE summary_month_user AS
SELECT
    month,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY month, member_casual;

CREATE TABLE summary_hour_user AS
SELECT
    hour,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY hour, member_casual;

CREATE TABLE summary_weekend_user AS
SELECT
    CASE
        WHEN day_of_week IN ('Saturday','Sunday') THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
GROUP BY day_type, member_casual;

CREATE TABLE summary_age_user AS
SELECT
    CASE
        WHEN age IS NULL THEN 'Unknown'
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
GROUP BY age_group, member_casual;

CREATE TABLE summary_gender_user AS
SELECT
    CASE
        WHEN gender IS NULL OR TRIM(gender) = '' THEN 'Unknown'
        ELSE gender
    END AS gender,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
GROUP BY gender, member_casual;

CREATE TABLE summary_ride_length AS
SELECT
    CASE
        WHEN ride_length_minutes < 10 THEN '0-10 min'
        WHEN ride_length_minutes < 20 THEN '10-20 min'
        WHEN ride_length_minutes < 30 THEN '20-30 min'
        WHEN ride_length_minutes < 60 THEN '30-60 min'
        WHEN ride_length_minutes < 120 THEN '60-120 min'
        ELSE '120+ min'
    END AS ride_length_group,
    COUNT(*) AS ride_count
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY ride_length_group;
