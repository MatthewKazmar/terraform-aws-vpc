# terraform-aws-vpc

This module creates a basic VPC with 4 subnets.
- Workload subnets in 2 AZs.
- TGW attachment subnets in 2 AZs.
- Internet gateway with default route.

Optionally, the TGW attachment is set up.
- Attach VPC to TGW in the specified Route Table. See https://github.com/MatthewKazmar/terraform-aws-tgw.
- Propagates the VPC CIDR to a Route table. Route Table can be the same as the attachment or specified.
- RFC routes to TGW attachment.

Example:
```
module "aws_prod_east_vpc" {
  providers = {
    aws = aws.east
  }

  source = "github.com/MatthewKazmar/terraform-aws-vpc"

  name       = "prod-east-vpc"
  cidr_block = "10.2.2.0/24"
  tgw_attachment = {
    tgw_id                     = module.aws_tgw_east.tgw.id
    association_route_table_id = module.aws_tgw_east.tgw_route_tables["prod"].id
    propagation_route_table_id = module.aws_tgw_east.tgw_route_tables["prod"].id
  }
}
```
