import duckdb

df = duckdb.query("SELECT * FROM 'data/demo.csv'").to_df()
print(df)
