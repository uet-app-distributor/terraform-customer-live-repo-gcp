data "aws_subnet" "public" {
  id = var.subnet_id
}

data "aws_vpc" "customer" {
  id = var.vpc_id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical
  owners = ["099720109477"]
}

locals {
  default_instance_type = "t3.micro"
  orchestrator_ssh_key  = "orchestrator-${uuid()}"
}


resource "aws_network_interface" "customer_app_instance" {
  subnet_id   = data.aws_subnet.public.id
  private_ips = [cidrhost(data.aws_subnet.public.cidr_block, 10)]
}

resource "aws_security_group" "customer_app_instance" {
  name   = "allow_required_rules"
  vpc_id = data.aws_vpc.customer.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.customer_app_instance.id
  network_interface_id = aws_network_interface.customer_app_instance.id
}

resource "aws_eip" "customer_app_instance" {
  count    = var.enabled_public_ip ? 1 : 0
  instance = aws_instance.customer_app.id
}

resource "aws_instance" "customer_app" {
  ami           = var.instance_ami != "" ? var.instance_ami : data.aws_ami.ubuntu.id
  instance_type = local.default_instance_type

  key_name = length(aws_key_pair.orchestrator) == 1 ? aws_key_pair.orchestrator[0].id : null

  network_interface {
    network_interface_id = aws_network_interface.customer_app_instance.id
    device_index         = 0
  }

  tags = var.default_tags
}

resource "aws_key_pair" "orchestrator" {
  count = var.ssh_public_key != "" ? 1 : 0

  key_name   = local.orchestrator_ssh_key
  public_key = var.ssh_public_key
}