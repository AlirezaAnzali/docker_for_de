import os
import requests
import pandas as pd

URL = "https://api.coingecko.com/api/v3/coins/markets"
PARAMS = {
    "vs_currency": "usd",
    "order": "market_cap_desc",
    "per_page": 20,
    "page": 1,
    "sparkline": "false",
}

def main():
    out_dir = os.environ.get("OUTPUT_DIR", "/data")
    os.makedirs(out_dir, exist_ok=True)

    r = requests.get(URL, params=PARAMS, timeout=30)
    r.raise_for_status()

    df = pd.DataFrame(r.json())
    out_path = os.path.join(out_dir, "coingecko_markets.csv")
    df.to_csv(out_path, index=False)

    print(f"Saved {len(df)} rows to {out_path}")

if __name__ == "__main__":
    main()
