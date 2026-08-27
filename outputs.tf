output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.dev_vpc.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet."
  value       = aws_subnet.dev_public_subnet.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet."
  value       = aws_subnet.dev_private_subnet.id
}

output "availability_zones" {
  description = "The availability zones in the region."
  value       = data.aws_availability_zones.available.names
}

output "account_info" {
  description = "The AWS account information."
  value       = " ${data.aws_caller_identity.current.account_id} | ${data.aws_caller_identity.current.arn} | ${data.aws_region.current.region} | ${data.aws_caller_identity.current.user_id}"
}