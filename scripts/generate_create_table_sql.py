import pandas as pd
import os
import re

# File paths
csv_path = "../data/processed/cleaned_bank_data.csv"
sql_output_path = "../sql/create_tables/create_table_bank_marketing.sql"
table_name = "bank_marketing"

# Load the cleaned CSV
df = pd.read_csv(csv_path)

# Mapping pandas dtypes to PostgreSQL types
dtype_map = {
    "int64": "INTEGER",
    "float64": "FLOAT",
    "object": "TEXT",
    "bool": "BOOLEAN"
}

# Set of PostgreSQL reserved keywords to quote if used as column names
reserved_keywords = {
    "all", "analyse", "analyze", "and", "any", "array", "as", "asc", "asymmetric", "authorization",
    "binary", "both", "case", "cast", "check", "collate", "column", "constraint", "create", "cross",
    "current_date", "current_role", "current_time", "current_timestamp", "current_user", "default",
    "deferrable", "desc", "distinct", "do", "else", "end", "except", "false", "fetch", "for", "foreign",
    "from", "grant", "group", "having", "in", "initially", "intersect", "into", "join", "leading",
    "limit", "localtime", "localtimestamp", "new", "not", "null", "off", "offset", "old", "on", "only",
    "or", "order", "placing", "primary", "references", "returning", "select", "session_user", "some",
    "symmetric", "table", "then", "to", "trailing", "true", "union", "unique", "user", "using", "variadic",
    "verbose", "when", "where", "window", "with"
}

# Clean column names and generate SQL-safe lines
column_lines = []
for col in df.columns:
    clean_col = re.sub(r'\W+', '_', col.strip().lower())  # Replace non-word characters with _
    
    # Quote if column starts with a digit or is a reserved keyword
    if clean_col[0].isdigit() or clean_col in reserved_keywords:
        clean_col = f'"{clean_col}"'

    pg_type = dtype_map.get(str(df[col].dtype), "TEXT")  # Default to TEXT
    column_lines.append(f"    {clean_col} {pg_type}")

# Final CREATE TABLE SQL
create_table_sql = f"""DROP TABLE IF EXISTS {table_name};

CREATE TABLE {table_name} (
{',\n'.join(column_lines)}
);
"""

# Save SQL file
os.makedirs(os.path.dirname(sql_output_path), exist_ok=True)
with open(sql_output_path, "w") as f:
    f.write(create_table_sql)

print(f"✅ Safe CREATE TABLE script saved to: {sql_output_path}")
