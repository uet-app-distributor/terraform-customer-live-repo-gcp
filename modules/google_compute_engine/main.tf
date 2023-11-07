resource "google_compute_instance" "customer" {
  name                      = var.instance_name
  machine_type              = var.instance_machine_type
  allow_stopping_for_update = var.allow_stopping_for_update

  tags = var.instance_tags

  boot_disk {
    initialize_params {
      image = var.instance_image
      type  = var.instance_boot_disk_type
    }
  }

  network_interface {
    subnetwork = var.subnetwork_name
    access_config {
      nat_ip = var.static_public_ip
    }
  }

  metadata = {
    "ssh-keys" = <<-EOT
      ${join("\n", var.ssh_keys)}
    EOT
  }
}