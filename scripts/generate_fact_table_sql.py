import pandas as pd
import os
import re

# Paths
csv_path = "../data/processed/cleaned_bank_data.csv"
sql_output_path = "../sql/create_tables/create_fact_table.sql"
table_name = "bank_marketing_fact"

# Columns to normalize into dimension tables
dim_columns = ['job', 'marital', 'education', 'contact', 'poutcome']

# Reserved keywords in PostgreSQL
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

# Mapping pandas dtypes to PostgreSQL
dtype_map = {
    "int64": "INTEGER",
    "float64": "FLOAT",
    "object": "TEXT",
    "bool": "BOOLEAN"
}

# Function to clean column names for Postgres and return mapping
def clean_and_quote(name):
    cleaned = re.sub(r'\W+', '_', name.strip().lower())
    if cleaned[0].isdigit() or cleaned in reserved_keywords:
        return f'"{cleaned}"'
    return cleaned

# Load the cleaned dataset
df = pd.read_csv(csv_path)

# Store a mapping between original column name and cleaned/quoted version
column_map = {}
for col in df.columns:
    safe_col = clean_and_quote(col)
    column_map[col] = safe_col

# Generate column definitions
column_defs = []
for orig_col, clean_col in column_map.items():
    if orig_col in dim_columns:
        fk_col = f"{orig_col}_id"
        ref_table = f"dim_{orig_col}"
        ref_pk = f"{orig_col}_id"
        if fk_col[0].isdigit() or fk_col in reserved_keywords:
            fk_col = f'"{fk_col}"'
        column_defs.append(f"    {fk_col} INTEGER REFERENCES {ref_table}({ref_pk})")
    else:
        pg_type = dtype_map.get(str(df[orig_col].dtype), "TEXT")
        column_defs.append(f"    {clean_col} {pg_type}")

# Compose SQL
lines = [f"DROP TABLE IF EXISTS {table_name};", f"CREATE TABLE {table_name} ("]
lines.append(",\n".join(column_defs))
lines.append(");")

# Save SQL
os.makedirs(os.path.dirname(sql_output_path), exist_ok=True)
with open(sql_output_path, "w") as f:
    f.write("\n".join(lines))

print(f"✅ Fact table SQL script saved to: {sql_output_path}")
