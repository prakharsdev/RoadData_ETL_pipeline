import os
from google.cloud import storage

def extract_data():
    client = storage.Client()
    bucket = client.bucket('my-eyevi-bucket')
    blobs = bucket.list_blobs()

    for blob in blobs:
        # Download each file to the local directory
        blob.download_to_filename(os.path.join('/tmp', blob.name))

    print("Data extraction complete.")
