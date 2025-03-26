import pandas as pd
import os
import re

# Load the cleaned data
csv_path = "../data/processed/cleaned_bank_data.csv"
df = pd.read_csv(csv_path)

# Define columns to normalize into dimension tables
dim_columns = ['job', 'marital', 'education', 'contact', 'poutcome']

# Utility to clean column/table names for PostgreSQL
def clean_name(name):
    return re.sub(r'\W+', '_', name.strip().lower())

# Store SQL scripts
dim_sql_scripts = []

for col in dim_columns:
    values = df[col].dropna().unique()
    cleaned_col = clean_name(col)
    table_name = f"dim_{cleaned_col}"
    pk = f"{cleaned_col}_id"
    value_col = f"{cleaned_col}_value"

    # Create table and insert script
    lines = [
        f"DROP TABLE IF EXISTS {table_name};",
        f"CREATE TABLE {table_name} (",
        f"    {pk} SERIAL PRIMARY KEY,",
        f"    {value_col} TEXT UNIQUE NOT NULL",
        ");",
        f"-- Insert values into {table_name}",
    ]

    # Insert each unique value into the dimension table
    for val in sorted(values):
        safe_val = val.replace("'", "''")  # escape single quotes
        lines.append(f"INSERT INTO {table_name} ({value_col}) VALUES ('{safe_val}');")

    dim_sql_scripts.append(('\n'.join(lines), table_name))

# Save to SQL file
output_path = "../sql/create_tables/create_dimension_tables.sql"
os.makedirs(os.path.dirname(output_path), exist_ok=True)

with open(output_path, "w") as f:
    for script, table_name in dim_sql_scripts:
        f.write(f"-- {table_name} dimension\n")
        f.write(script + "\n\n")

print(f"✅ Dimension table creation script saved to: {output_path}")
