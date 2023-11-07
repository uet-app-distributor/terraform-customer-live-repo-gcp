variable "subnet_id" {
  type        = string
  default     = ""
  description = "Subnet ID for customer app instance."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID"
}

variable "enabled_public_ip" {
  type        = bool
  default     = true
  description = "Enable/disable auto-assign a public IPv4 on customer app instance."
}

variable "ssh_public_key" {
  type        = string
  default     = ""
  description = "SSH public key"
}

variable "instance_ami" {
  type        = string
  default     = ""
  description = "AMI ID for customer app instance"
}
