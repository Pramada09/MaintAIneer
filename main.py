from fastapi import FastAPI
from sqlalchemy import create_engine
import pandas as pd
import joblib

app = FastAPI(title="Navy AI API")

engine = create_engine(
    "postgresql://<DB_USER>:<DB_PASSWORD>@<DB_HOST>:5432/<DB_NAME>"
)

# Load Models
xgb_scaler = joblib.load(
    r"C:\Users\pramadaa\models\xgb_scaler.pkl"
)

xgb_model = joblib.load(
    r"C:\Users\pramadaa\models\xgboost_model.pkl"
)
@app.get("/")
def home():
    return {"status": "Navy AI API Running!"}

@app.get("/api/predictions")
def get_predictions():
    df = pd.read_sql(
        """
        SELECT *
        FROM ai_predictions
        ORDER BY predicted_at DESC
        LIMIT 100
        """,
        engine
    )
    return df.to_dict(orient="records")


## api alerts 

@app.get("/api/alerts")
def get_alerts():
    df = pd.read_sql(
        """
        SELECT *
        FROM maintenance_alerts
        ORDER BY alert_time DESC
        """,
        engine
    )
    return df.to_dict(orient="records")