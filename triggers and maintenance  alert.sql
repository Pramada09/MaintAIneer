----  maintanace alerts table

CREATE TABLE IF NOT EXISTS maintenance_alerts (
    alert_id SERIAL PRIMARY KEY,
    ship_name TEXT,
    predicted_at TIMESTAMP,
    risk_score REAL,
    alert_level TEXT,
    alert_time TIMESTAMP DEFAULT NOW()
);

---- crete function 

CREATE OR REPLACE FUNCTION trigger_maintenance_alert()
RETURNS TRIGGER
AS
$$
BEGIN

    -- Critical Alert
    IF NEW.risk_score > 0.005 THEN

        INSERT INTO maintenance_alerts
        (
            ship_name,
            predicted_at,
            risk_score,
            alert_level
        )
        VALUES
        (
            NEW.ship_name,
            NEW.predicted_at,
            NEW.risk_score,
            'CRITICAL'
        );

    -- Warning Alert
    ELSIF NEW.risk_score > 0.001 THEN

        INSERT INTO maintenance_alerts
        (
            ship_name,
            predicted_at,
            risk_score,
            alert_level
        )
        VALUES
        (
            NEW.ship_name,
            NEW.predicted_at,
            NEW.risk_score,
            'WARNING'
        );

    END IF;

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;




DROP TRIGGER IF EXISTS trg_maintenance_alert
ON ai_predictions;


--- craete trigger


CREATE TRIGGER trg_maintenance_alert
AFTER INSERT
ON ai_predictions
FOR EACH ROW
EXECUTE FUNCTION trigger_maintenance_alert();

INSERT INTO ai_predictions
(
    ship_name,
    predicted_at,
    risk_score,
    alert_level
)
VALUES
(
    'INS_Test',
    NOW(),
    0.006,
    'CRITICAL'
);

INSERT INTO ai_predictions
(
    ship_name,
    predicted_at,
    risk_score,
    alert_level
)
VALUES
(
    'INS_Test2',
    NOW(),
    0.002,
    'WARNING'
);


-- check

SELECT *
FROM maintenance_alerts;