SELECT * FROM engine_monitoring;

ALTER TABLE engine_monitoring RENAME COLUMN "Ship_Name" TO ship_name;
ALTER TABLE engine_monitoring RENAME COLUMN "Engine_ID" TO engine_id;
ALTER TABLE engine_monitoring RENAME COLUMN "Temperature_C" TO temperature_c;
ALTER TABLE engine_monitoring RENAME COLUMN "Pressure_PSI" TO pressure_psi;
ALTER TABLE engine_monitoring RENAME COLUMN "Vibration_mm" TO vibration_mm;
ALTER TABLE engine_monitoring RENAME COLUMN "RPM" TO rpm;
ALTER TABLE engine_monitoring RENAME COLUMN "Maintenance_Status" TO maintenance_status;
ALTER TABLE engine_monitoring RENAME COLUMN "Timestamp" TO timestamp;


-- 1. Average Temperature per Engine
SELECT engine_id, AVG(Temperature_C) AS avg_temp
FROM engine_monitoring
GROUP BY engine_id ;

-- 2. Max Pressure & Min Vibration per Engine
SELECT 
    engine_id,
    MAX(pressure_psi) AS max_pressure,
    MIN(vibration_mm) AS min_vibration
FROM engine_monitoring
GROUP BY engine_id;

-- 3. Total Maintenance Count
SELECT COUNT(*) AS maintenance_count
FROM engine_monitoring
WHERE maintenance_status = 1;

-- 4. Average RPM per Engine
SELECT engine_id, AVG(rpm) AS avg_rpm
FROM engine_monitoring
GROUP BY engine_id;

-- 5. Create Ships Table
CREATE TABLE ships (
    ship_id VARCHAR(50) PRIMARY KEY,
    ship_name VARCHAR(100)
);

-- 6. Insert Ship Records
INSERT INTO ships (ship_id, ship_name) VALUES
('ENG_001', 'INS Vikrant'),
('ENG_002', 'INS Kolkata'),
('ENG_003', 'INS Chennai');


-- 7. Inner Join — Engine with Ship Name
SELECT s.engine_id, sh.ship_name, s.temperature_c
FROM engine_monitoring s
JOIN ships sh
ON s.engine_id = sh.ship_id;

-- 8. Left Join — All Engines with Ship Names
SELECT s.engine_id, sh.ship_name
FROM engine_monitoring s
LEFT JOIN ships sh
ON s.engine_id = sh.ship_id;

-- 9. Create View — High Temperature Engines
CREATE VIEW high_temp_engines AS
SELECT *
FROM engine_monitoring 
WHERE temperature_c > 80;

-- 10. Query the High Temp View
SELECT * FROM high_temp_engines;

-- 11. Create View — Engines Needing Maintenance
CREATE VIEW maintenance_required AS
SELECT *
FROM engine_monitoring 
WHERE maintenance_status = 1;

-- 12. Row Number per Engine
SELECT 
    engine_id,
    timestamp,
    temperature_c,
    ROW_NUMBER() OVER (PARTITION BY engine_id ORDER BY timestamp) AS row_num
FROM engine_monitoring ;

-- 13. Running Average Temperature per Engine
SELECT 
    engine_id,
    timestamp,
    temperature_c,
    AVG(temperature_c) OVER (PARTITION BY engine_id ORDER BY timestamp) AS running_avg_temp
FROM engine_monitoring ;

-- 14. RPM Ranking Across All Engines
SELECT 
    engine_id,
    rpm,
    RANK() OVER (ORDER BY rpm DESC) AS rpm_rank
FROM engine_monitoring ;

-- 15. 5-Row Moving Average Temperature
SELECT 
    engine_id,
    timestamp,
    temperature_c,
    AVG(temperature_c) OVER (
        PARTITION BY engine_id 
        ORDER BY timestamp 
        ROWS BETWEEN 4 PRECEDING AND CURRENT ROW
    ) AS moving_avg
FROM engine_monitoring ;

-- 16. Index on Engine ID
CREATE INDEX idx_engine_id
ON engine_monitoring (engine_id);

-- 17. Index on Timestamp
CREATE INDEX idx_timestamp
ON engine_monitoring (timestamp);

-- 18. Composite Index on Engine ID + Timestamp
CREATE INDEX idx_engine_time
ON engine_monitoring (engine_id, timestamp);

-- 19. Delete Engine ID Index
DROP INDEX idx_engine_id;

-- 20. Critical Engine Alert Count
SELECT engine_id, COUNT(*) AS critical_count
FROM engine_monitoring 
WHERE temperature_c > 80 
  AND vibration_mm > 5
GROUP BY engine_id
ORDER BY critical_count DESC;

-- 21. Latest Sensor Reading per Engine
SELECT DISTINCT ON (engine_id)
    engine_id, timestamp, temperature_c, pressure_psi
FROM engine_monitoring 
ORDER BY engine_id, timestamp DESC;
