locals {}

module "network" {
  source     = "../../modules/aws-vpc"
  cidr_block = "10.0.0.0/16"
  enable_ig  = true
}

module "compute" {
  source            = "../../modules/aws-ec2"
  subnet_id         = module.network.public_subnet_id
  vpc_id            = module.network.vpc_id
  enabled_public_ip = true

  # Customized AMI with required services pre-installed
  instance_ami = "ami-07b8f89f83b5d30d6"

  # Orchestrator public SSH key
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjerKo+sJjYbyHqP+WMmsniu0nuiH6YtvdJWCRRN4ShvVLFGQ4Bc7C+h6UKBC6K3NknIsIxu83VRWzzqAfzSR4aGF709iglrzCEPfh9Mmvk0TzOn5QWFkL6x1cvuZlpIEuP8aYtmvLvkqZv2aDGwv9hDtY4gbbE7NzEhCMF7211kzwkcIa84PIJ1gLGQTu12OaVCJwil6mFyV17AIngXOhe2qZEgkXUCsMqtyTEq5IO6aNkEY5QQKo/2gtTZEfUxR6d2svvFynF0ShN8i4XWd19defCxp929lu0JvxRrszVz2bueXwba9uVDBTaD0LRPu8two3iqNK1Wpl1UkSoZd2BBPPrYHJV7PPxpvrb1gc+InmjQzxcYioWE3mknYy393pvH6W6oTZzyNWmVi7Tk/s/UeknE6zEkV5g9A2xdspS6r78/q2cpWg9FSX1Bd66cZuxA6qAHGKCGIMhE6oc3xR+PYBUh6I35u1Dj1JGz1XtBQrB852j2L+rCcAUxuHxIc= thainguyen.uet@gmail.com"
}

output "customer_app_instance_public_ip" {
  value = module.compute.customer_app_instance_public_ip
}
