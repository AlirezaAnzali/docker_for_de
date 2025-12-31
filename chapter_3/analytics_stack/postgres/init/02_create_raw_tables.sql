CREATE TABLE IF NOT EXISTS raw.customers (
    cust_id INT,
    full_name TEXT,
    province TEXT,
    signup_dt TEXT
);

CREATE TABLE IF NOT EXISTS raw.accounts (
    acct_id INT,
    cust_id INT,
    type TEXT,
    open_date TEXT,
    status_flag TEXT
);

CREATE TABLE IF NOT EXISTS raw.transactions (
    txn_id INT,
    acct_id INT,
    txn_dt TEXT,
    txn_desc TEXT,
    amt TEXT
);
