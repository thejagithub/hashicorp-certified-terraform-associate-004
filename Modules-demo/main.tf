module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.2"

  name = var.vpc_name
  cidr = var.cidr_block
}

module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  vpc_id = module.vpc.vpc_id
  name   = var.security_group_name
}