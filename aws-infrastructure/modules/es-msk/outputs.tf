output "msk-bootstrap-brokers" {
  description = "Connections host:port pairs"
  value       = aws_msk_cluster.es-msk.bootstrap_brokers
}
