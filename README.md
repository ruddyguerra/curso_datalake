# 🧪 Proyecto Data Lake con: MinIO + PySpark + Airflow + Trino + DuckDB

Este proyecto levanta un entorno completo para simular un Data Lake moderno en tu máquina local utilizando contenedores Docker.

---

## 🔧 Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- VSCode
- Sistema operativo: Windows/macOS/Linux

---

## 📦 ¿Qué contiene este proyecto?

| Servicio | Descripción |
|----------|-------------|
| **MinIO** | Simulación local de Amazon S3 |
| **PySpark** | Procesamiento de archivos CSV a Parquet |
| **boto3** | Subida de archivos a MinIO desde Python |
| **DuckDB** | Consultas SQL directas sobre archivos locales |
| **Trino** | Consultas SQL sobre Parquet en S3 (MinIO) |
| **Airflow** | Automatización de pipelines con DAGs |

---

## 📁 Estructura

```
curso_datalake/
├── docker-compose.yml
├── Dockerfile
├── data/                    # Archivos CSV de entrada
│   └── demo.csv
├── scripts/                 # Scripts Python
│   ├── upload_csv_to_minio.py
│   ├── csv_to_parquet_s3.py
│   └── query_duckdb.py
├── dags/                   # DAG de Airflow
│   └── csv_to_parquet_dag.py
└── trino/etc/catalog/      # Configuración del conector Hive para Trino
    └── hive.properties
```

---

## 🚀 Instrucciones de uso

### 1. Levanta los contenedores

```bash
docker-compose up -d --build
```

Para reconstruir

```bash
docker-compose build app
docker-compose up -d
```

Para validar los procesos

```bash
docker ps
docker inspect app
```

Se iniciarán los servicios en:

- MinIO → [http://localhost:9001](http://localhost:9001)  
  Usuario: `minioadmin`, Contraseña: `minioadmin`
- Airflow → [http://localhost:8080](http://localhost:8080)  
  Usuario: `admin`, Contraseña: `admin`
- Trino → [http://localhost:8081](http://localhost:8081)

---

### 2. Ejecuta los scripts manuales

```bash
docker exec -it app bash
```

Dentro del contenedor, ejecuta en orden:

```bash
python scripts/upload_csv_to_minio.py
python scripts/csv_to_parquet_s3.py
python scripts/query_duckdb.py
```

---

### 3. Verifica resultados

#### ✅ En MinIO

- Bucket: `demo-bucket`
- Archivos esperados:
  - `demo.csv`
  - Carpeta `output_parquet/` con archivos Parquet

#### ✅ En Airflow

1. Entra al UI: [http://localhost:8080](http://localhost:8080)
2. Activa y ejecuta el DAG: `csv_to_parquet_pipeline`
3. Visualiza los logs de cada tarea

#### ✅ En Trino

```bash
docker-compose up -d trino
```

```bash
docker exec -it trino trino
```

Y ejecuta:

```sql
SHOW CATALOGS;
SHOW SCHEMAS FROM hive;
SHOW TABLES FROM hive."demo-bucket";
SELECT * FROM hive."demo-bucket"."output_parquet" LIMIT 10;
```

#### ✅ En DuckDB

Consulta local sobre archivos CSV:

```bash
python scripts/query_duckdb.py
```

---

## ✨ Extras

- Puedes agregar más archivos CSV a la carpeta `data/` para probar.

---

## 📬 Autor

Preparado por Ruddy Guerra para entrenamiento sobre Data Lakes modernos con herramientas de código abierto y Python.