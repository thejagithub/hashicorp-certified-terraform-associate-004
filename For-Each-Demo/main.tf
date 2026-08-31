data "aws_region" "current" {}

locals {

  common_tags = {
    Environment = var.environment
    Project     = "terraform-demo"
    Owner       = "infrastructure-team"
    CostCenter  = "cc-1234"
    Region      = data.aws_region.current.region
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket" "for-each-demo" {
  for_each = var.bucket_names
  bucket   = each.value

  tags = {
    Name        = "${each.value}-${var.environment}-thejana-rrtdrd"
    Environment = local.common_tags.Environment
    Project     = local.common_tags.Project
    Owner       = local.common_tags.Owner
    CostCenter  = local.common_tags.CostCenter
    Region      = local.common_tags.Region
    ManagedBy   = local.common_tags.ManagedBy
  }

}