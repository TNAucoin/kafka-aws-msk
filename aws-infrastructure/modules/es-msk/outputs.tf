output "msk-bootstrap-brokers" {
  description = "Connections host:port pairs"
  value       = aws_msk_cluster.es-msk.bootstrap_brokers
}

output "msk-bootstrap-brokers-tls" {
  description = "TLS Broker Connections"
  value       = aws_msk_cluster.es-msk.bootstrap_brokers_tls
}

output "msk-brokers-node-group-info" {
  description = "Broker node group info"
  value       = aws_msk_cluster.es-msk.broker_node_group_info
}
