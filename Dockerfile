FROM python:3.10-slim

# Variables de entorno
ENV SPARK_VERSION=3.4.2 \
    HADOOP_VERSION=3 \
    SPARK_HOME=/opt/spark \
    PATH="/opt/spark/bin:$PATH"

# Instala dependencias necesarias
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk wget curl unzip git && \
    pip install --upgrade pip && \
    pip install boto3 duckdb pyspark numpy pandas && \
    apt-get clean

# Descarga y descomprime Spark
RUN mkdir -p /opt/spark && \
    curl -L https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | \
    tar -xz -C /opt/spark --strip-components=1

# Agrega dependencias para acceso S3A
RUN mkdir -p /opt/spark/jars && \
    curl -L -o /opt/spark/jars/hadoop-aws-3.3.4.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.4/hadoop-aws-3.3.4.jar && \
    curl -L -o /opt/spark/jars/aws-java-sdk-bundle-1.11.1026.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar

# Copia tu código
WORKDIR /app
COPY . .

CMD [ "bash" ]
