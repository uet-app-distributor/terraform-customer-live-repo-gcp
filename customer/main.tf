resource "random_id" "suffix" {
  byte_length = 2
}


module "network" {
  source     = "../modules/google_compute_network"
  network_name = "customer-managed-network"
  resource_suffix = "-${random_id.suffix.hex}"
}

module "compute" {
  source                = "../modules/google_compute_engine"
  instance_name         = "customer-managed-instance-${random_id.suffix.hex}"
  instance_machine_type = "e2-micro"
  instance_image        = "ubuntu-os-cloud/ubuntu-2204-lts"

  subnetwork_name  = module.network.subnetwork_name
  static_public_ip = module.network.instance_static_public_ip_address

  ssh_keys = [
    "customer:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjerKo+sJjYbyHqP+WMmsniu0nuiH6YtvdJWCRRN4ShvVLFGQ4Bc7C+h6UKBC6K3NknIsIxu83VRWzzqAfzSR4aGF709iglrzCEPfh9Mmvk0TzOn5QWFkL6x1cvuZlpIEuP8aYtmvLvkqZv2aDGwv9hDtY4gbbE7NzEhCMF7211kzwkcIa84PIJ1gLGQTu12OaVCJwil6mFyV17AIngXOhe2qZEgkXUCsMqtyTEq5IO6aNkEY5QQKo/2gtTZEfUxR6d2svvFynF0ShN8i4XWd19defCxp929lu0JvxRrszVz2bueXwba9uVDBTaD0LRPu8two3iqNK1Wpl1UkSoZd2BBPPrYHJV7PPxpvrb1gc+InmjQzxcYioWE3mknYy393pvH6W6oTZzyNWmVi7Tk/s/UeknE6zEkV5g9A2xdspS6r78/q2cpWg9FSX1Bd66cZuxA6qAHGKCGIMhE6oc3xR+PYBUh6I35u1Dj1JGz1XtBQrB852j2L+rCcAUxuHxIc= thainguyen.uet@gmail.com",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjerKo+sJjYbyHqP+WMmsniu0nuiH6YtvdJWCRRN4ShvVLFGQ4Bc7C+h6UKBC6K3NknIsIxu83VRWzzqAfzSR4aGF709iglrzCEPfh9Mmvk0TzOn5QWFkL6x1cvuZlpIEuP8aYtmvLvkqZv2aDGwv9hDtY4gbbE7NzEhCMF7211kzwkcIa84PIJ1gLGQTu12OaVCJwil6mFyV17AIngXOhe2qZEgkXUCsMqtyTEq5IO6aNkEY5QQKo/2gtTZEfUxR6d2svvFynF0ShN8i4XWd19defCxp929lu0JvxRrszVz2bueXwba9uVDBTaD0LRPu8two3iqNK1Wpl1UkSoZd2BBPPrYHJV7PPxpvrb1gc+InmjQzxcYioWE3mknYy393pvH6W6oTZzyNWmVi7Tk/s/UeknE6zEkV5g9A2xdspS6r78/q2cpWg9FSX1Bd66cZuxA6qAHGKCGIMhE6oc3xR+PYBUh6I35u1Dj1JGz1XtBQrB852j2L+rCcAUxuHxIc= thainguyen.uet@gmail.com"
  ]
}

output "customer_app_instance_public_ip" {
  value = module.network.instance_static_public_ip_address
}
