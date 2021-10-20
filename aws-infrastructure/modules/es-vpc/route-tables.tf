resource "aws_route_table" "es-public-route-table" {
  vpc_id = aws_vpc.es-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.es-internet-gateway.id
  }
  tags = {
    Name = "es-public-route-table"
  }
}

resource "aws_route_table_association" "es-public-route-table-public-subnet-a" {
  subnet_id      = aws_subnet.es-public-subnet-a.id
  route_table_id = aws_route_table.es-public-route-table.id
}

resource "aws_route_table_association" "es-public-route-table-public-subnet-b" {
  subnet_id      = aws_subnet.es-public-subnet-b.id
  route_table_id = aws_route_table.es-public-route-table.id
}

resource "aws_route_table_association" "es-public-route-table-public-subnet-c" {
  subnet_id      = aws_subnet.es-public-subnet-c.id
  route_table_id = aws_route_table.es-public-route-table.id
}
