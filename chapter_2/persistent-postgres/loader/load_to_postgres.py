import pandas as pd
import psycopg2

# 1. Connect to Postgres (via Docker network)
conn = psycopg2.connect(
    host="pg",
    port=5432,
    dbname="warehouse",
    user="etl",
    password="etlpass"
)

# 2. Read enriched CSV from bind mount
df = pd.read_csv("/input/sales.csv")

cur = conn.cursor()

# 3. Create table (warehouse-style schema)
cur.execute("""
CREATE TABLE IF NOT EXISTS sales (
    customer_id TEXT,
    customer_name TEXT,
    city TEXT,
    province TEXT,
    product TEXT,
    category TEXT,
    quantity INT,
    unit_price NUMERIC(10,2),
    order_date DATE,
    total_amount NUMERIC(12,2)
)
""")

# 4. Load data row by row
for _, r in df.iterrows():
    cur.execute(
        """
        INSERT INTO sales VALUES (
            %s, %s, %s, %s, %s,
            %s, %s, %s, %s, %s
        )
        """,
        (
            r["customer_id"],
            r["customer_name"],
            r["city"],
            r["province"],
            r["product"],
            r["category"],
            int(r["quantity"]),
            float(r["unit_price"]),
            r["order_date"],
            float(r["total_amount"])
        )
    )

conn.commit()
cur.close()
conn.close()

print("Sales data loaded into Postgres successfully")

