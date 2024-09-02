output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "instance_names" {
  value = [for instance in google_compute_instance.default : instance.name]
}
