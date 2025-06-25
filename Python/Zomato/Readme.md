# 🍽️ Zomato Restaurant Data Cleaning Project

This project is a beginner-friendly Python data cleaning exercise using the Zomato restaurant dataset. The goal is to take messy raw data and transform it into a clean, structured format ready for analysis.

---

## 📌 Objective

We will clean a CSV file from Zomato by:
- Removing duplicates
- Fixing missing values
- Cleaning column names
- Formatting ratings and votes
- Exporting the cleaned dataset as an Excel file

---

## 🧰 Tools Used

- Python 3.x  
- Jupyter Notebook  
- Pandas  
- OpenPyXL (for Excel export)

---

## 📁 Project Files

| File Name              | Purpose                                |
|------------------------|----------------------------------------|
| `Zomato_Project.ipynb` | The notebook with all data cleaning steps |
| `Zomato data .csv`     | Raw Zomato dataset (input)             |
| `Zomato_Cleaned.xlsx`  | Cleaned and exported Excel dataset     |
| `README.md`            | Project documentation                  |

---

## 🧠 Complete Project Code with Explanation

```python
# 🍽️ Zomato Data Cleaning Script

# STEP 1: Import necessary libraries
import pandas as pd

# STEP 2: Load the raw dataset
df = pd.read_csv("Zomato data .csv")

# Show the first few rows
print("🔍 Preview of raw data:")
print(df.head())

# STEP 3: Drop unnecessary columns if they exist
columns_to_drop = ['url', 'phone']
df.drop(columns=[col for col in columns_to_drop if col in df.columns], inplace=True)

# STEP 4: Remove duplicate rows
df.drop_duplicates(inplace=True)

# STEP 5: Handle missing values
# Drop rows where 'name' or 'location' is missing
df.dropna(subset=['name', 'location'], inplace=True)

# Fill missing ratings with 'Not Rated'
if 'rating' in df.columns:
    df['rating'] = df['rating'].fillna('Not Rated')

# STEP 6: Clean column names
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')

# STEP 7: Clean specific columns
# Remove "/5" from rating strings
if 'rating' in df.columns:
    df['rating'] = df['rating'].astype(str).str.replace('/5', '', regex=False).str.strip()

# Convert votes to numeric format
if 'votes' in df.columns:
    df['votes'] = pd.to_numeric(df['votes'], errors='coerce')

# STEP 8: Preview cleaned data
print("\n✅ Cleaned data preview:")
print(df.head())

# STEP 9: Export cleaned data to Excel
df.to_excel("Zomato_Cleaned.xlsx", index=False)
print("\n📁 Exported: Zomato_Cleaned.xlsx")
