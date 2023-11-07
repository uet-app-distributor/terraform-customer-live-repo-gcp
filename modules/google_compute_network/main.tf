resource "google_compute_network" "network" {
  name = var.network_name
}

resource "google_compute_subnetwork" "main" {
  name          = "${var.network_name}-main-subnet"
  network       = google_compute_network.network.id
  ip_cidr_range = var.subnetwork_ip_cidr_range
}

resource "google_compute_firewall" "default" {
  name    = "default-firewall-rule"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.allowed_source_range
}

resource "google_compute_address" "instance_static_public_ip" {
  name = "instance-static-public-ip"
}