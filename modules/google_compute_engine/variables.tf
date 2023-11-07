############################################
## Required variables
############################################

variable "instance_name" {
  type        = string
  description = "Name of Compute Engine instance"
}

variable "instance_machine_type" {
  type        = string
  description = "Machine type of Compute Engine instance"
}

variable "subnetwork_name" {
  type        = string
  description = "Name of subnetwork to attach to the network interface of the instance"
}

############################################
## Optional variables
############################################
variable "allow_stopping_for_update" {
  type        = bool
  default     = true
  description = "Allow Terraform to stop instance to update"
}


variable "static_public_ip" {
  type        = string
  default     = ""
  description = "Static public IP"
}

variable "instance_tags" {
  type        = list(string)
  default     = []
  description = "List of tags for instance"
}

variable "default_sa_scopes" {
  type        = list(string)
  default     = ["cloud-platform"]
  description = "Default scopes of instance service account"
}

variable "ssh_keys" {
  type = list(string)
  default = []
  description = "SSH keys for instance"
}

variable "instance_image" {
  type        = string
  default     = "debian-cloud/debian-11"
  description = "Machine image for instance"
}

variable "instance_boot_disk_type" {
  type        = string
  default     = "pd-standard"
  description = "Type of boot disk for instance"
}
