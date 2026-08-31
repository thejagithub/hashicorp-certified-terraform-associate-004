variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-northeast-1"
}

# Variables for count
# variable "subnet_count" {
#   description = "Number of subnets to create"
#   type        = number
#   default     = 3
# }

# variable "availability_zones" {
#   description = "Availability zones for subnets"
#   type        = list(string)
#   default     = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
# }

# variable "subnet_cidr_blocks" {
#   description = "CIDR blocks for subnets"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
# }

# Variables for For-Each

variable "subnet_configs" {
  description = "Map of subnet configurations"
  type        = map(string)

  default = {
    "public" = "10.0.10.0/24"

    "private" = "10.0.20.0/24"

    "data" = "10.0.30.0/24"
  }
}


variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = map(string)
  default = {
    "public"  = "ap-northeast-1a"
    "private" = "ap-northeast-1c"
    "data"    = "ap-northeast-1d"
  }
}

# variable "security_groups" {
#   description = "Security group configurations"
#   type = list(object({
#     name         = string
#     description  = string
#     ingress_port = number
#   }))
#   default = [
#     {
#       name         = "web"
#       description  = "Allow web traffic"
#       ingress_port = 80
#     },
#     {
#       name         = "app"
#       description  = "Allow application traffic"
#       ingress_port = 8080
#     },
#     {
#       name         = "db"
#       description  = "Allow database traffic"
#       ingress_port = 3306
#     }
#   ]
# }