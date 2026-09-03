# removed all the resources from the main configuration to demonstrate state refactoring.

# VPC
# resource "aws_vpc" "main" {
#   cidr_block = var.vpc_cidr

#   tags = {
#     Name        = "${var.prefix}-vpc"
#     Environment = var.environment
#   }
# }

# Subnet
# resource "aws_subnet" "app" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = var.subnet_cidr

#   tags = {
#     Name        = "${var.prefix}-subnet"
#     Environment = var.environment
#   }
# }

# moved the subnet resource from a module to the main configuration to demonstrate state refactoring. The following block is commented out because the subnet is now managed by the main configuration.

# moved {
#   from = module.network.aws_subnet.app
#   to   = aws_subnet.app
# }

# module "network" {
#   source      = "./modules/network"
#   vpc_id      = aws_vpc.main.id
#   subnet_cidr = var.subnet_cidr
#   prefix      = var.prefix
#   environment = var.environment
#   lab_name    = "lab-9"
# }

# moved the subnet resource to a module from the main configuration to demonstrate state refactoring. The following block is commented out because the subnet is now managed by the network module.

# moved {
#   from = aws_subnet.app
#   to   = module.network.aws_subnet.app
# }

# Route Table
# resource "aws_route_table" "main" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name        = "${var.prefix}-rt"
#     Environment = var.environment
#   }
# }

# Security Group
# resource "aws_security_group" "web-modified" {
#   name        = "${var.prefix}-web-sg"
#   description = "Lab security group"
#   vpc_id      = aws_vpc.main.id

#   tags = {
#     Name        = "${var.prefix}-web-sg"
#     Environment = var.environment
#   }
# }

# moved the security group resource to a new resource name to demonstrate state refactoring. The following block is commented out because the security group is now managed by a new resource name.

# moved {
#   from = aws_security_group.web
#   to   = aws_security_group.web-modified
# }

# removed the route table resource to a new resource name to demonstrate state refactoring.

# removed all the resources from the main configuration to demonstrate state refactoring.

# removed {
#   from = aws_route_table.main

#   lifecycle {
#     destroy = false
#   }
# }

# removed {
#   from = aws_vpc.main
#   lifecycle {
#     destroy = false
#   }
# }

# removed {
#   from = aws_subnet.app

#   lifecycle {
#     destroy = false
#   }
# }

# removed {
#   from = aws_security_group.web-modified

#   lifecycle {
#     destroy = false
#   }
# }



#VPC
# imported via the cli using the command: terraform import aws_vpc.main "vpc-0aabb8db0d424419e"
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "${var.prefix}-vpc"
    Environment = var.environment
  }
}

# Subnet
# imported via the import block
resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr

  tags = {
    Name        = "${var.prefix}-subnet"
    Environment = var.environment
  }
}

import {
    to = aws_subnet.app
    id = "subnet-0869e378f642f96f0"
}

import {
    to = aws_security_group.web-modified
    id = "sg-0b1a82fc8764b1333"
}

# this configuration is grabbed from the command 'terrafrom plan -generate-config-out=generated.txt'. The usage of this command is to generate a configuration file from the existing state. The generated configuration file can be used as a starting point for refactoring or modifying the infrastructure.

resource "aws_security_group" "web-modified" {
  description            = "Lab security group"
  name                   = "${var.prefix}-web-sg"
  region                 = "ap-northeast-1"
  tags = {
    Environment = "${var.environment}"
    Name        = "${var.prefix}-web-sg"
  }
  tags_all = {
    Environment = "${var.environment}"
    Name        = "${var.prefix}-web-sg"
  }
  vpc_id = aws_vpc.main.id
}


# Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.prefix}-rt"
    Environment = var.environment
  }
}

import {
    to = aws_route_table.main
    id = "rtb-02a0e7a85581495ff"
}




