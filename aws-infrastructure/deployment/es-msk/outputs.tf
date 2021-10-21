output "msk-bootstrap-brokers" {
  description = "Bootstrap Broker Connections"
  value       = module.es-msk.msk-bootstrap-brokers
}
