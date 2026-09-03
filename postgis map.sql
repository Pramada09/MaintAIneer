CREATE EXTENSION postgis;

SELECT PostGIS_Version();

ALTER TABLE ships
ADD COLUMN location GEOMETRY(Point,4326);


SELECT *
FROM ships;

UPDATE ships
SET location =
ST_SetSRID(
ST_MakePoint(72.8777,19.0760),
4326
)
WHERE ship_name='INS Vikrant';

UPDATE ships
SET location =
ST_SetSRID(
ST_MakePoint(88.3639,22.5726),
4326
)
WHERE ship_name='INS Kolkata';


UPDATE ships
SET location =
ST_SetSRID(
ST_MakePoint(80.2707,13.0827),
4326
)
WHERE ship_name='INS Chennai';


SELECT
ship_name,
ST_AsText(location)
FROM ships;


SELECT
ship_name,
ST_X(location) AS longitude,
ST_Y(location) AS latitude
FROM ships;


SELECT
s.ship_name,
ST_X(s.location) AS longitude,
ST_Y(s.location) AS latitude,
a.risk_score,
a.alert_level

FROM ships s
JOIN ai_predictions a
ON s.ship_name = a.ship_name;

SELECT
    ship_name,
    ST_AsText(location)
FROM ships;

CREATE OR REPLACE VIEW ship_risk_map AS
SELECT
    s.ship_name,
    ST_X(s.location) AS longitude,
    ST_Y(s.location) AS latitude,
    a.risk_score,
    a.alert_level
FROM ships s
JOIN ai_predictions a
ON s.ship_name = a.ship_name;