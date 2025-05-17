import boto3
from botocore.client import Config

s3 = boto3.client(
    's3',
    endpoint_url='http://minio:9000',
    aws_access_key_id='minioadmin',
    aws_secret_access_key='minioadmin',
    config=Config(signature_version='s3v4'),
    region_name='us-east-1'
)

bucket_name = 'demo-bucket'
try:
    s3.create_bucket(Bucket=bucket_name)
except s3.exceptions.ClientError as e:
    if e.response['Error']['Code'] != 'BucketAlreadyOwnedByYou':
        raise

s3.upload_file('./data/demo.csv', bucket_name, 'demo.csv')
print("✅ CSV subido a MinIO con éxito.")
