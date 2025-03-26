import os
import pandas as pd
from sqlalchemy import create_engine

# 📌 DB Connection Info (update as needed)
DB_USER = "postgres"
DB_PASS = "1234567890"
DB_HOST = "localhost"
DB_PORT = "5432"
DB_NAME = "postgres"

# Paths
kpi_sql_dir = "../sql/kpi"
export_dir = "../data/export"
os.makedirs(export_dir, exist_ok=True)

# Connect to PostgreSQL
engine = create_engine(f"postgresql://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Scan and run all SQL files
for filename in os.listdir(kpi_sql_dir):
    if filename.endswith(".sql"):
        sql_file_path = os.path.join(kpi_sql_dir, filename)
        with open(sql_file_path, "r", encoding="utf-8") as file:
            query = file.read()

        try:
            df = pd.read_sql_query(query, con=engine)
            export_path = os.path.join(export_dir, filename.replace(".sql", ".csv"))
            df.to_csv(export_path, index=False)
            print(f"✅ Exported: {export_path}")
        except Exception as e:
            print(f"❌ Error running {filename}: {e}")

print("\n🎉 All KPI query results exported to /data/export/")
