import pandas as pd
from sqlalchemy import create_engine, text

engine = create_engine(
    "postgresql+psycopg2://etl:etlpass@pg:5432/warehouse"
)

with engine.begin() as conn:
    conn.execute(text("""
        TRUNCATE TABLE
            raw.customers,
            raw.accounts,
            raw.transactions;
    """))

datasets = {
    "customers": "/data/raw/raw_customers.csv",
    "accounts": "/data/raw/raw_accounts.csv",
    "transactions": "/data/raw/raw_transactions.csv",
}

for table, path in datasets.items():
    df = pd.read_csv(path)
    df.to_sql(
        table,
        engine,
        schema="raw",
        if_exists="append",
        index=False
    )
    print(f"Loaded raw.{table}")

