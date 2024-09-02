# Configure the Google Cloud provider
provider "google" {
  credentials = file("🍌🍎")
  project     = "my-eyevi-project"
  region      = "us-central1"
}

# Create a Google Kubernetes Engine (GKE) cluster
resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "us-central1"
  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# Create 100 VMs with specific configurations
resource "google_compute_instance" "default" {
  count        = 100
  name         = "instance-${count.index}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
