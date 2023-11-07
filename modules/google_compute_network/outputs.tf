output "network_name" {
  value       = google_compute_network.network.name
  description = "Name of the network"
}

output "subnetwork_name" {
  value       = google_compute_subnetwork.main.name
  description = "Name of the main subnetwork"
}

output "instance_static_public_ip_address" {
  value       = google_compute_address.instance_static_public_ip.address
  description = "Static Public IP address for an instance"
}
