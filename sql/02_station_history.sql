-- Station history/reference workflow used in the project.
-- The individual station tables were retained as staging sources.
-- stations_all preserves station characteristics by period.

CREATE TABLE stations_all (
    station_id INT,
    name TEXT,
    city TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    dpcapacity INT,
    landmark INT,
    online_date VARCHAR(50),
    period VARCHAR(20)
);

-- Standardized INSERT pattern:
-- Older periods receive NULL for columns that did not exist in the source.
--
-- Example:
--
-- INSERT INTO stations_all
-- (station_id, name, city, latitude, longitude, dpcapacity,
--  landmark, online_date, period)
-- SELECT
--     id, name, NULL, latitude, longitude, dpcapacity,
--     landmark, NULL, '2015'
-- FROM divvy_stations_2015;
--
-- Repeat for each available station-period table.
--
-- A master list can then be derived:
--
-- CREATE TABLE stations_master AS
-- SELECT
--     station_id,
--     MIN(period) AS first_seen,
--     MAX(period) AS last_seen
-- FROM stations_all
-- GROUP BY station_id;
