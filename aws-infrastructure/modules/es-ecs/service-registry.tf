resource "aws_service_discovery_private_dns_namespace" "es-service-discovery" {
  name = "ecs.local"
  vpc  = var.vpc_id
}

resource "aws_service_discovery_service" "es-kafka-schema-registry" {
  name = "es-kafka-schema-registry"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.es-service-discovery.id
    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_service_discovery_service" "es-kafka-connect" {
  name = "es-kafka-connect"
  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.es-service-discovery.id
    dns_records {
      ttl  = 10
      type = "A"
    }
  }
  health_check_custom_config {
    failure_threshold = 1
  }
}

