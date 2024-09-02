import pandas as pd

def transform_data():
    # Example transformation: Normalize data
    data = pd.read_csv('/tmp/raw_data.csv')
    data['normalized_column'] = (data['original_column'] - data['original_column'].mean()) / data['original_column'].std()
    data.to_csv('/tmp/transformed_data.csv', index=False)

    print("Data transformation complete.")
