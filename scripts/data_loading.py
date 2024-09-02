from google.cloud import bigquery
from google.cloud import storage

def load_data():
    # Load transformed data into BigQuery
    client = bigquery.Client()
    table_id = 'my-eyevi-project.my_dataset.my_table'

    job_config = bigquery.LoadJobConfig(
        autodetect=True,
        source_format=bigquery.SourceFormat.CSV,
    )

    with open('/tmp/transformed_data.csv', "rb") as source_file:
        job = client.load_table_from_file(source_file, table_id, job_config=job_config)

    job.result()  # Wait for the job to complete

    print("Data loaded into BigQuery.")

    # Upload processed image data to Cloud Storage
    storage_client = storage.Client()
    bucket = storage_client.bucket('my-eyevi-processed-images')
    blob = bucket.blob('processed_image_metadata.csv')
    blob.upload_from_filename('/tmp/processed_image_metadata.csv')

    print("Processed image metadata uploaded to Cloud Storage.")
