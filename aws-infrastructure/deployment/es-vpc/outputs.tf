output "es-vpc" {
  description = "ES VPC"
  value       = module.es-vpc.es-vpc
}
output "es-public-subnet-a" {
  description = "es Public Subnet A"
  value       = module.es-vpc.es-public-subnet-a
}
output "es-public-subnet-b" {
  description = "es Public Subnet B"
  value       = module.es-vpc.es-public-subnet-b
}
output "es-public-subnet-c" {
  description = "es Public Subnet C"
  value       = module.es-vpc.es-public-subnet-c
}
