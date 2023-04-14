data "aws_availability_zones" "this" {
  state = "available"
}

data "http" "myip" {
  url = "http://ifconfig.me"
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = merge({
    Name           = var.name,
    Network_Domain = var.network_domain
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "this" {
  route_table_id         = aws_vpc.this.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id

  ingress {
    description = "RFC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  ingress {
    description = "admin"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = var.name
    },
    var.tags
  )
}

resource "aws_subnet" "workload" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 3, count.index)
  availability_zone = data.aws_availability_zones.this.names[count.index]

  tags = merge({
    Name           = var.name,
    Network_Domain = var.network_domain
    },
    var.tags
  )
}

resource "aws_subnet" "tgw" {
  count = 2

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 3, count.index + 2)
  availability_zone = data.aws_availability_zones.this.names[count.index]

  tags = merge({
    Name           = var.name,
    Network_Domain = var.network_domain
    },
    var.tags
  )
}