import pandas as pd
import numpy as np
import os

# Define input and output paths
input_path = "../data/raw/bank-direct-marketing-campaigns.csv"
output_dir = "../data/processed"
output_file = "cleaned_bank_data.csv"
output_path = os.path.join(output_dir, output_file)

# Create output directory if it doesn't exist
os.makedirs(output_dir, exist_ok=True)

# Load the dataset (uses comma separator)
df = pd.read_csv(input_path, sep=",")

# Convert string columns to lowercase
df = df.apply(lambda col: col.str.lower() if col.dtype == "object" else col)

# Replace 'unknown' values with NaN
df.replace("unknown", np.nan, inplace=True)

# Save cleaned data
df.to_csv(output_path, index=False)

print(f"✅ Cleaned data saved to: {output_path}")
