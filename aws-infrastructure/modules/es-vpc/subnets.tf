data "aws_region" "current_region" {}

resource "aws_subnet" "es-public-subnet-a" {
  vpc_id                  = aws_vpc.es-vpc.id
  availability_zone       = "${data.aws_region.current_region.name}a"
  cidr_block              = cidrsubnet(aws_vpc.es-vpc.cidr_block, 4, 0)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "es-public-subnet-a"
  }
}

resource "aws_subnet" "es-public-subnet-b" {
  vpc_id                  = aws_vpc.es-vpc.id
  availability_zone       = "${data.aws_region.current_region.name}b"
  cidr_block              = cidrsubnet(aws_vpc.es-vpc.cidr_block, 4, 1)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "es-public-subnet-b"
  }
}

resource "aws_subnet" "es-public-subnet-c" {
  vpc_id                  = aws_vpc.es-vpc.id
  availability_zone       = "${data.aws_region.current_region.name}c"
  cidr_block              = cidrsubnet(aws_vpc.es-vpc.cidr_block, 4, 2)
  map_public_ip_on_launch = "true"
  tags = {
    Name = "es-public-subnet-c"
  }
}
