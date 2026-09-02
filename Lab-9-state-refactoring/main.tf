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
removed {
  from = aws_route_table.main

  lifecycle {
    destroy = false
  }
}

removed {
  from = aws_vpc.main
  lifecycle {
    destroy = false
  }
}

removed {
  from = aws_subnet.app

  lifecycle {
    destroy = false
  }
}

removed {
  from = aws_security_group.web-modified

  lifecycle {
    destroy = false
  }
}