resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true

  tags {
    Name   = var.PlaygroundName
    Reason = "Playground"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags {
    Name   = var.PlaygroundName
    Reason = "Playground"
  }
}

resource "aws_eip" "ngw_ip" {}

resource "aws_nat_gateway" "ngw" {
  count         = var.private_subnets > 0 ? 1 : 0
  allocation_id = aws_eip.ngw_ip.id
  subnet_id     = aws_subnet.public_subnets.0.id

  tags {
    Name   = var.PlaygroundName
    Reason = "Playground"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets > 0 ? var.public_subnets : 1
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, 10 + count.index)
  availability_zone       = element(data.aws_availability_zones.zones.names, count.index)
  map_public_ip_on_launch = true

  tags {
    Name   = "${var.PlaygroundName}-${count.index}"
    Reason = "Playground"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = var.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 100 + count.index)
  availability_zone = element(data.aws_availability_zones.zones.names, count.index)

  tags {
    Name   = "${var.PlaygroundName}-${count.index}"
    Reason = "Playground"
  }
}