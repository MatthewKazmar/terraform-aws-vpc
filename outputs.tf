output "vpc" {
  description = "The AWS instance resource."
  value       = aws_vpc.this
}

output "subnet_workload" {
  description = "The AWS Subnet resource for Workload."
  value       = aws_subnet.workload
}

output "subnet_tgw" {
  description = "The AWS Subnet resource for TGW."
  value       = aws_subnet.tgw
}

output "security_group" {
  description = "The AWS Security Group resource."
  value       = aws_security_group.this
}