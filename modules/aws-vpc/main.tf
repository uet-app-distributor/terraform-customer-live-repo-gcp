resource "aws_vpc" "customer" {
  cidr_block = var.cidr_block
  tags       = merge(var.vpc_tags, var.default_tags)
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.customer.id
  cidr_block = cidrsubnet(aws_vpc.customer.cidr_block, 4, 15)
  tags       = merge(var.subnet_tags, var.default_tags)
}

resource "aws_internet_gateway" "gw" {
  count = var.enable_ig ? 1 : 0

  vpc_id = aws_vpc.customer.id
  tags   = var.default_tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.customer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw[0].id
  }

  depends_on = [aws_internet_gateway.gw]
}