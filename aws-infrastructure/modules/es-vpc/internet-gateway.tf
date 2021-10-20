resource "aws_internet_gateway" "es-internet-gateway" {
  vpc_id = aws_vpc.es-vpc.id
  tags = {
    Name = "es-internet-gateway"
  }
}
