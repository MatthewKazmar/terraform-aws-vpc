output "aws_vpc" {
  description = "The AWS instance resource."
  value       = aws_vpc.this
}

output "aws_subnet_workload" {
  description = "The AWS Subnet resource for Workload."
  value       = aws_subnet.workload.this
}

output "aws_subnet_tgw" {
  description = "The AWS Subnet resource for TGW."
  value       = aws_subnet.tgw.this
}

output "aws_security_group" {
  description = "The AWS Security Group resource."
  value       = aws_security_group.this
}