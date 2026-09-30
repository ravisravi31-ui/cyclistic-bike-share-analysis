-- Cyclistic 2019 analysis
-- Database setup

CREATE DATABASE IF NOT EXISTS divvy_analysis;
USE divvy_analysis;

-- Raw 2019 trip staging table.
CREATE TABLE IF NOT EXISTS trips_2019_staging (
    trip_id BIGINT PRIMARY KEY,
    start_time VARCHAR(30),
    end_time VARCHAR(30),
    bikeid INT,
    tripduration VARCHAR(30),
    from_station_id INT,
    from_station_name TEXT,
    to_station_id INT,
    to_station_name TEXT,
    usertype VARCHAR(50),
    gender VARCHAR(20),
    birthyear VARCHAR(20),
    period VARCHAR(20)
);
