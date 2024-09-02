import os
import logging
from google.cloud import bigquery, storage
from airflow.models import Variable

# Setup logging for Airflow tasks
def get_logger():
    logger = logging.getLogger('airflow.task')
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)
        logger.addHandler(handler)
    logger.setLevel(logging.INFO)
    return logger

logger = get_logger()

# Google Cloud Storage Client
def get_gcs_client():
    return storage.Client()

# Google BigQuery Client
def get_bq_client():
    return bigquery.Client()

# Load Airflow Variables
def load_variable(var_name, default_value=None):
    return Variable.get(var_name, default_var=default_value)

# Example function to upload a file to Google Cloud Storage
def upload_to_gcs(bucket_name, source_file_name, destination_blob_name):
    client = get_gcs_client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_filename(source_file_name)
    logger.info(f"File {source_file_name} uploaded to {destination_blob_name} in bucket {bucket_name}.")

# Example function to load data into BigQuery
def load_to_bigquery(table_id, source_file_name, schema):
    client = get_bq_client()
    job_config = bigquery.LoadJobConfig(
        schema=schema,
        source_format=bigquery.SourceFormat.CSV,
        write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
    )

    with open(source_file_name, "rb") as source_file:
        job = client.load_table_from_file(source_file, table_id, job_config=job_config)

    job.result()  # Wait for the job to complete
    logger.info(f"Loaded data from {source_file_name} into BigQuery table {table_id}.")

# Example function to download a file from Google Cloud Storage
def download_from_gcs(bucket_name, source_blob_name, destination_file_name):
    client = get_gcs_client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)

    blob.download_to_filename(destination_file_name)
    logger.info(f"File {source_blob_name} downloaded from bucket {bucket_name} to {destination_file_name}.")

# Example schema for BigQuery table (adjust as needed)
def get_example_bq_schema():
    return [
        bigquery.SchemaField("id", "STRING"),
        bigquery.SchemaField("name", "STRING"),
        bigquery.SchemaField("email", "STRING"),
        bigquery.SchemaField("created_at", "TIMESTAMP"),
    ]

# Utility function to handle environment-specific configurations
def get_env_variable(var_name, default_value=None):
    return os.getenv(var_name, default_value)

# Example function to check if a file exists in Google Cloud Storage
def file_exists_in_gcs(bucket_name, blob_name):
    client = get_gcs_client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(blob_name)

    exists = blob.exists()
    logger.info(f"File {blob_name} existence in bucket {bucket_name}: {exists}")
    return exists
