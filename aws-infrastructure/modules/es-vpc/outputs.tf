output "es-vpc" {
  description = "es-vpc"
  value       = aws_vpc.es-vpc.id
}
output "es-public-subnet-a" {
  description = "Public Subnet A"
  value       = aws_subnet.es-public-subnet-a.id
}
output "es-public-subnet-b" {
  description = "Public Subnet B"
  value       = aws_subnet.es-public-subnet-b.id
}
output "es-public-subnet-c" {
  description = "Public Subnet C"
  value       = aws_subnet.es-public-subnet-c.id
}
