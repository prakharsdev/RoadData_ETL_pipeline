# Road Data ETL pipeline 

## Overview

Welcome to the Road Data Engineering project! This repository contains the code and configurations required to process large-scale geospatial data, including road panorama images, traffic signs, and road conditions. The project leverages various tools and technologies such as Docker, Kubernetes, Airflow, Terraform, BigQuery, Snowflake, and DBT to build robust ETL pipelines that transform raw data into actionable insights.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Setup Instructions](#setup-instructions)
3. [Tools and Technologies](#tools-and-technologies)
4. [ETL Pipeline Overview](#etl-pipeline-overview)
5. [DBT Models Overview](#dbt-models-overview)
6. [Infrastructure Provisioning](#infrastructure-provisioning)
7. [Deployment](#deployment)

## Project Structure

```bash
RoadData_ETL_pipeline/
│
├── docker/                   # Docker configuration files
│   ├── Dockerfile
│   └── docker-compose.yml
│
├── terraform/                # Terraform configuration files
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
│
├── airflow/                  # Airflow DAGs
│   └── dags/
│       ├── etl_pipeline.py
│       └── dependencies.py
│
├── scripts/                  # Python scripts for ETL tasks
│   ├── data_extraction.py
│   ├── data_transformation.py
│   ├── data_loading.py
│   └── utils.py
│
├── kubernetes/               # Kubernetes configuration files
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── secrets.yaml
│
├── dbt/                      # DBT models and configurations
│   ├── models/
│   │   ├── staging/
│   │   ├── core/
│   │   ├── intermediate/
│   │   └── final/
│   ├── dbt_project.yml
│   ├── profiles.yml
│   └── tests/
│
├── data/                     # Directories for raw and processed data
│   ├── raw/
│   ├── processed/
│   └── metadata/
│
├── monitoring/               # Monitoring configuration files
    ├── gcp_monitoring_config.yaml
    └── logs/


```

## Setup Instructions

### Prerequisites

Ensure you have the following installed on your local machine:

- [Docker](https://www.docker.com/get-started)
- [Kubernetes](https://kubernetes.io/docs/setup/) (If running locally, use [Minikube](https://minikube.sigs.k8s.io/docs/start/))
- [Terraform](https://www.terraform.io/downloads)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) (for GCP operations)
- [DBT](https://docs.getdbt.com/docs/installation) (for data transformations)

### Environment Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/prakharsdev/RoadData_ETL_pipeline.git
   cd RoadData_ETL_pipeline
   ```

2. **Configure Google Cloud Authentication**
   - Download your service account JSON file and place it in the root directory of the project.
   - Set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable:
     ```bash
     export GOOGLE_APPLICATION_CREDENTIALS="path/to/your/service-account-file.json"
     ```

3. **Build Docker Images**
   - Build the Docker images using the provided `Dockerfile`:
     ```bash
     docker build -t eyevi-etl:latest -f docker/Dockerfile .
     ```

4. **Provision Infrastructure with Terraform**
   - Navigate to the `terraform` directory and initialize Terraform:
     ```bash
     cd terraform
     terraform init
     terraform apply
     ```

5. **Deploy to Kubernetes**
   - Use the Kubernetes configuration files to deploy your application:
     ```bash
     kubectl apply -f kubernetes/deployment.yaml
     kubectl apply -f kubernetes/service.yaml
     ```

6. **Set Up Airflow**
   - Deploy the Airflow DAGs and start the Airflow scheduler:
     ```bash
     cd airflow/dags
     airflow initdb
     airflow scheduler &
     airflow webserver -p 8080 &
     ```

7. **Run DBT Models**
   - Navigate to the `dbt` directory and run the DBT models:
     ```bash
     cd dbt
     dbt run
     ```

## Tools and Technologies

- **Docker**: Containerization of Python scripts and dependencies.
- **Kubernetes**: Orchestrates and manages containers across the cloud infrastructure.
- **Terraform**: Infrastructure as Code (IaC) for provisioning cloud resources on GCP.
- **Airflow**: Orchestrates ETL workflows.
- **DBT**: Performs data transformations and manages the transformation layer in BigQuery and Snowflake.
- **Google Cloud Platform (GCP)**: Cloud provider for infrastructure, storage, and data warehousing.
- **BigQuery & Snowflake**: Data warehousing solutions for storing and querying processed data.

## ETL Pipeline Overview

The ETL pipeline is designed to process large-scale geospatial data:

1. **Extraction**: Data is extracted from Google Cloud Storage using Python scripts.
2. **Transformation**: The data undergoes cleaning, normalization, and aggregation using Python and DBT models.
3. **Loading**: Processed data is loaded into BigQuery and Snowflake, with metadata and logs stored in Google Cloud Storage.

For more details, refer to the [ETL Pipeline Documentation](docs/ETL Pipeline Documentation.md).

## DBT Models Overview

The DBT models are structured as follows:

- **Staging Models**: Initial processing and cleaning of raw data.
- **Core Models**: Aggregation and summarization of staging data.
- **Intermediate Models**: Further transformations and metric calculations.
- **Final Models**: Data prepared for reporting and analysis.

Refer to the `/dbt/models/` directory for detailed SQL queries.

## Infrastructure Provisioning

Terraform is used to provision the following infrastructure:

- Google Kubernetes Engine (GKE) Cluster
- Virtual Machines (VMs) on Google Compute Engine
- Google Cloud Storage Buckets for raw and processed data
- Networking and security configurations

## Deployment

The deployment process involves building Docker containers, provisioning infrastructure with Terraform, and deploying applications using Kubernetes. Airflow manages the ETL pipeline, and DBT handles further data transformations.

---

This `README.md` provides a clear and detailed guide for setting up, running, and understanding the Road Data ETL pipeline Data Engineering project. It is structured to help collaborators and users get started quickly and understand the project's components and workflows.
