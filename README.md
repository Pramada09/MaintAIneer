# ⚓ MaintAIneer
### AI-Driven Predictive Maintenance & Situational Awareness System

MaintAIneer is an AI-powered predictive maintenance project designed to monitor equipment health, detect abnormal behavior, estimate maintenance risk, and present actionable insights through APIs and dashboards.

## 🎯 Problem

Traditional maintenance can be reactive: equipment is serviced after a failure or on a fixed schedule. MaintAIneer uses historical sensor and maintenance data to identify anomalies and predict risk earlier.

## 💡 Solution

The project combines machine learning, time-series analysis, database management, and business intelligence:

- 🔍 **Isolation Forest** for anomaly detection
- ⚠️ **XGBoost** for maintenance-risk classification
- 📈 **LSTM** for time-series forecasting
- 🗄️ **PostgreSQL** for structured data storage
- 🚀 **FastAPI** for serving predictions through APIs
- 📊 **Power BI** for monitoring and decision support
- 🗺️ **PostGIS / spatial concepts** for location-aware situational awareness
- ⚙️ **SQL triggers/procedures** for database automation and alerts

## 🏗️ High-Level Architecture

```text
Sensor / Maintenance Data
          ↓
     Data Cleaning
          ↓
    Feature Engineering
          ↓
 ┌────────┼───────────┐
 ↓        ↓           ↓
Isolation XGBoost     LSTM
Forest    Risk Model  Forecasting
 └────────┼───────────┘
          ↓
      PostgreSQL
          ↓
       FastAPI
          ↓
      Power BI
          ↓
 Maintenance Insights & Alerts
```

## 🛠️ Tech Stack

| Area | Technologies |
|---|---|
| Programming | Python, SQL |
| Data Science | Pandas, NumPy |
| Machine Learning | Scikit-learn, XGBoost |
| Deep Learning | TensorFlow / Keras |
| Database | PostgreSQL |
| API | FastAPI, Uvicorn |
| Visualization | Power BI, Matplotlib, Seaborn |
| Time Series | LSTM |
| Version Control | Git, GitHub |

## 📂 Suggested Project Structure

```text
MaintAIneer/
├── README.md
├── .gitignore
├── .env.example
├── requirements.txt
├── api/
├── notebooks/
├── sql/
├── dashboard/
├── presentation/
└── models/
```

> Model files and secrets should not be committed to a public repository. Use `.env` for local credentials and keep it out of Git.

## 🔐 Environment Setup

Create a local `.env` file based on `.env.example`:

```env
DB_USER=postgres
DB_PASSWORD=your_password_here
DB_HOST=localhost
DB_PORT=5432
DB_NAME=MaintAIneer
```

Never commit `.env` or real passwords.

## 🚀 Running the API

Install dependencies:

```bash
pip install -r requirements.txt
```

Start the FastAPI application:

```bash
uvicorn api.main:app --reload
```

If your `main.py` remains in the project root, use:

```bash
uvicorn main:app --reload
```

## 📊 Dashboard

Power BI is used to present fleet/equipment information, prediction outputs, maintenance risk, and anomaly insights in a decision-friendly format.

Add dashboard screenshots to `dashboard/` when publishing the repository.

## 📌 Key Learning Outcomes

- End-to-end machine learning workflow
- Anomaly detection and classification
- Time-series modeling with LSTM
- PostgreSQL database integration
- REST API development with FastAPI
- Power BI dashboard development
- Database automation using SQL
- Secure handling of configuration and credentials

## 👩‍💻 Author

**Pramada Katkar**  
BSc Data Science Honours Student  
Aspiring Data Scientist | Machine Learning Enthusiast

- LinkedIn: https://www.linkedin.com/in/pramada-katkar-1a3693338/
- GitHub: https://github.com/Pramada09

---

⭐ If you find this project interesting, feel free to star the repository!
