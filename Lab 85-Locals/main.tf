# Get information about the current AWS region.
data "aws_region" "current" {}
data "aws_availability_zones" "available" {
  state = "available"
}

# Create a locals block to define common tags for resources.
locals {
  common_tags = {
    Environment = var.environment
    Project     = "terraform-demo"
    Owner       = "infrastructure-team"
    CostCenter  = "cc-1234"
    Region      = data.aws_region.current.region
    ManagedBy   = "terraform"
  }
  name_prefix = "${var.environment}-"
}
# Static configuration with repetitive elements
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${local.name_prefix}vpc-us-east-1"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${local.name_prefix}${data.aws_availability_zones.available.names[0]}-public-subnet-1a"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
    Tier        = "public"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${local.name_prefix}${data.aws_availability_zones.available.names[1]}-public-subnet-1b"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
    Tier        = "public"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${local.name_prefix}${data.aws_availability_zones.available.names[0]}-private-subnet-1a"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
    Tier        = "private"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "${local.name_prefix}${data.aws_availability_zones.available.names[1]}-private-subnet-1b"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
    Tier        = "private"
  }
}

resource "aws_security_group" "web" {
  name        = "${local.name_prefix}web-sg"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.main.id

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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.name_prefix}web-sg"
    Environment = "local.common_tags.Environment"
    Project     = "local.common_tags.Project"
    Owner       = "local.common_tags.Owner"
    CostCenter  = "local.common_tags.CostCenter"
    Region      = "local.common_tags.Region"
    ManagedBy   = "local.common_tags.ManagedBy"
  }
}