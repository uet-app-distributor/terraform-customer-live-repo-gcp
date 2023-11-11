variable "network_name" {
  type        = string
  description = "Name of the network"
}

variable "subnetwork_ip_cidr_range" {
  type        = string
  default     = "10.1.0.0/16"
  description = "IP CIDR range for the main subnetwork"
}

variable "allowed_source_range" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "Source IP ranges for the default firewall rule"
}

variable "allowed_ports" {
  type        = list(string)
  default     = ["22", "80", "443", "8080"]
  description = "Allowed ports for the default firewall rule"
}

variable resource_suffix {
  type        = string
  default     = ""
  description = "Suffix for resources"
}

