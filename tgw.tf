resource "aws_route" "rfc_10" {
  count = var.tgw_attachment == null ? 0 : 1

  route_table_id         = aws_vpc.this.default_route_table_id
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = var.tgw_attachment["tgw_id"]
}

resource "aws_route" "rfc_172" {
  count = var.tgw_attachment == null ? 0 : 1

  route_table_id         = aws_vpc.this.default_route_table_id
  destination_cidr_block = "172.16.0.0/12"
  transit_gateway_id     = var.tgw_attachment["tgw_id"]
}

resource "aws_route" "rfc_192" {
  count = var.tgw_attachment == null ? 0 : 1

  route_table_id         = aws_vpc.this.default_route_table_id
  destination_cidr_block = "192.168.0.0/16"
  transit_gateway_id     = var.tgw_attachment["tgw_id"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  count = var.tgw_attachment == null ? 0 : 1

  subnet_ids         = aws_subnet.tgw[*].id
  vpc_id             = aws_vpc.this.id
  transit_gateway_id = var.tgw_attachment["tgw_id"]

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = local.tags
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  count = var.tgw_attachment == null ? 0 : 1

  transit_gateway_attachment_id  = one(aws_ec2_transit_gateway_vpc_attachment.this).id
  transit_gateway_route_table_id = var.tgw_attachment["association_route_table_id"]
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  count = var.tgw_attachment == null ? 0 : 1

  transit_gateway_attachment_id  = one(aws_ec2_transit_gateway_vpc_attachment.this).id
  transit_gateway_route_table_id = coalesce(var.tgw_attachment["propagation_route_table_id"], var.tgw_attachment["association_route_table_id"])
}