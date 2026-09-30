-- Staging import pattern for 2019 quarterly CSVs.
-- Replace the Windows path with your own local path.
-- LOAD DATA LOCAL INFILE requires local_infile to be enabled on both
-- the MySQL server and the client.

-- Q1 example:
LOAD DATA LOCAL INFILE 'D:/path/to/Divvy_Trips_2019_Q1.csv'
INTO TABLE trips_2019_staging
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    trip_id,
    start_time,
    end_time,
    bikeid,
    tripduration,
    from_station_id,
    from_station_name,
    to_station_id,
    to_station_name,
    usertype,
    gender,
    birthyear
)
SET period = '2019_Q1';

-- Repeat the same pattern for Q2, Q3 and Q4,
-- changing the file path and SET period value.
