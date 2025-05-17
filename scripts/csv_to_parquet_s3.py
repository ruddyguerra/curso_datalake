from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("CSV to Parquet") \
    .config("spark.hadoop.fs.s3a.endpoint", "http://minio:9000") \
    .config("spark.hadoop.fs.s3a.access.key", "minioadmin") \
    .config("spark.hadoop.fs.s3a.secret.key", "minioadmin") \
    .config("spark.hadoop.fs.s3a.path.style.access", "true") \
    .config("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem") \
    .getOrCreate()

df = spark.read.option("header", "true").csv("s3a://demo-bucket/demo.csv")
df.show()
df.write.mode("overwrite").parquet("s3a://demo-bucket/output_parquet/")
print("✅ CSV convertido a Parquet.")
spark.stop()
