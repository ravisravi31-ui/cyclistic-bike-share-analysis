USE divvy_analysis;

-- 1. Overall descriptive statistics
SELECT
    COUNT(*) AS total_trips,
    ROUND(AVG(ride_length_minutes), 2) AS mean_ride_length_minutes,
    MAX(ride_length_minutes) AS max_ride_length_minutes
FROM trips_2019;

-- 2. Mode day of week
SELECT day_of_week, COUNT(*) AS ride_count
FROM trips_2019
GROUP BY day_of_week
ORDER BY ride_count DESC
LIMIT 1;

-- 3. Member vs Casual
SELECT
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY member_casual;

-- 4. Member/Casual by day
SELECT
    day_of_week,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY day_of_week, member_casual;

-- 5. Member/Casual by month
SELECT
    month,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY month, member_casual
ORDER BY month, member_casual;

-- 6. Member/Casual by hour
SELECT
    hour,
    member_casual,
    COUNT(*) AS ride_count,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_length
FROM trips_2019
WHERE ride_length_minutes IS NOT NULL
GROUP BY hour, member_casual
ORDER BY hour, member_casual;

-- 7. Weekday vs Weekend
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

-- 8. Ride-length distribution
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

-- 9. Age groups
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

-- 10. Gender
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

-- 11. Top starting stations
SELECT
    from_station_id AS station_id,
    COUNT(*) AS ride_count
FROM trips_2019_staging
GROUP BY from_station_id
ORDER BY ride_count DESC
LIMIT 10;

-- 12. Top ending stations
SELECT
    to_station_id AS station_id,
    COUNT(*) AS ride_count
FROM trips_2019_staging
GROUP BY to_station_id
ORDER BY ride_count DESC
LIMIT 10;

-- 13. Top station-to-station routes (exclude same-station trips)
SELECT
    from_station_id,
    to_station_id,
    COUNT(*) AS ride_count
FROM trips_2019_staging
WHERE from_station_id <> to_station_id
GROUP BY from_station_id, to_station_id
ORDER BY ride_count DESC
LIMIT 10;
