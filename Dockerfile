FROM python:3.10-slim

RUN apt-get update && apt-get install -y openjdk-17-jdk wget curl && \
    pip install boto3 pyspark duckdb && \
    apt-get clean

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PYTHONUNBUFFERED=1

# Descargar los JAR necesarios para usar s3a://
RUN mkdir -p /opt/spark/jars && \
    curl -o /opt/spark/jars/hadoop-aws.jar https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.6/hadoop-aws-3.3.6.jar && \
    curl -o /opt/spark/jars/aws-java-sdk-bundle.jar https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar
