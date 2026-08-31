variable "environment" {
  description = "Environment name for resource naming and tagging"
  type        = string
  default     = "production"
}

variable "bucket_names" {
  description = "List of S3 bucket names to create"
  type        = set(string)
  default     = ["bucket1-thejana", "bucket2-thejana", "bucket3-thejana"]
}