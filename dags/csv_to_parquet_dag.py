from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

with DAG(
    dag_id="csv_to_parquet_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule_interval=None,
    catchup=False,
    tags=["datalake"]
) as dag:

    subir_csv = BashOperator(
        task_id="upload_csv",
        bash_command="python /app/scripts/upload_csv_to_minio.py"
    )

    convertir_parquet = BashOperator(
        task_id="convert_to_parquet",
        bash_command="python /app/scripts/csv_to_parquet_s3.py"
    )

    subir_csv >> convertir_parquet
