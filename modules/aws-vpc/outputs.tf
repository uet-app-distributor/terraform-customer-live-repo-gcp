output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "ID of the public subnet"
}

output "public_subnet_cidr" {
  value       = aws_subnet.public.cidr_block
  description = "CIDR of the public subnet"
}

output "vpc_id" {
  value       = aws_vpc.customer.id
  description = "VPC ID"
}
