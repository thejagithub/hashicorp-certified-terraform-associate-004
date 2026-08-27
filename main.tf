# This Terraform configuration file creates a VPC and two subnets (one public and one private) in AWS.


locals {

  common_tags = {
    Name        = "${var.environment}_vpc"
    Environment = var.environment
    Terraform   = "true"
  }
}
# Retrieve availability zones of the target region.
data "aws_availability_zones" "available" {
  state = "available"
}

# Retrieve data about the target region.
data "aws_region" "current" {}

# Retrieve data about the current AWS account.
data "aws_caller_identity" "current" {}

#dev vpc configuration.
resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr

  tags = local.common_tags

}

# dev public subnet configuration.
resource "aws_subnet" "dev_public_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = local.common_tags
}

# dev private subnet configuration.
resource "aws_subnet" "dev_private_subnet" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = local.common_tags
}

resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = local.common_tags
}

resource "aws_route_table" "dev_public_route_table" {
  vpc_id = aws_vpc.dev_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
  }
}

resource "aws_route_table_association" "dev_public_subnet_association" {
  subnet_id      = aws_subnet.dev_public_subnet.id
  route_table_id = aws_route_table.dev_public_route_table.id
}

resource "aws_security_group" "dev_sg" {
  name        = "dev_sg"
  description = "Security group for dev environment"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
