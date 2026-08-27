
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}
variable "private_subnet_name" {
  description = "The name of the private subnet."
  type        = string
  default     = "dev_private_subnet"
}
variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet."
  type        = string
  default     = "10.0.1.0/24"
}
variable "public_subnet_name" {
  description = "The name of the public subnet."
  type        = string
  default     = "dev_public_subnet"
}
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "environment" {
  description = "The environment for the resources."
  type        = string
  default     = "dev"
}

# variable "availability_zone" {
#   description = "The availability zone for the resources."
#   type        = string
#   default     = data.aws_availability_zones.available.names[0]
# }