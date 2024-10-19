resource "aws_subnet" "public" {
  count = 2

  vpc_id = aws_vpc.main.id

  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  cidr_block        = cidrsubnet(local.subnet_cidr_blocks.public, 1, count.index)

  map_public_ip_on_launch = true
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id = aws_vpc.main.id

  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  cidr_block        = cidrsubnet(local.subnet_cidr_blocks.private, 1, count.index)

  map_public_ip_on_launch = false
}
