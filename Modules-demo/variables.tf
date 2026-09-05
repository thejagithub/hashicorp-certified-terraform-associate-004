variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc-terraform-modules"
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "security-group-terraform-modules"
}