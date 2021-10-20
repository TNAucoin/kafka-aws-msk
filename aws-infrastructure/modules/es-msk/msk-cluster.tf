resource "aws_kms_key" "es-msk" {
  description = "es-msk"
}

resource "aws_security_group" "es-msk-sg" {
  name        = "es-msk-sg"
  description = "es msk security group"
  vpc_id      = var.vpc_id

  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Ingress for MSK cluster"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Egress for MSK cluster"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
}

resource "aws_msk_configuration" "es-msk" {
  kafka_versions    = [var.msk_kafka_version]
  name              = var.msk_configuration_name
  server_properties = <<PROPERTIES
    min.insync.replicas = ${var.msk_min_in_sync_replicas}
    default.replication.factor = ${var.msk_default_replication_factor}
    auto.create.topics.enable = true
    delete.topic.enable = true
    PROPERTIES
}

resource "aws_msk_cluster" "es-msk" {
  cluster_name           = "es-msk"
  enhanced_monitoring    = "DEFAULT"
  kafka_version          = var.msk_kafka_version
  number_of_broker_nodes = var.msk_number_of_brokers
  tags                   = {}

  broker_node_group_info {
    az_distribution = "DEFAULT"
    client_subnets  = var.subnet_ids
    security_groups = [aws_security_group.es-msk-sg.id]
    ebs_volume_size = var.msk_ebs_volume_size
    instance_type   = var.msk_instance_type
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.es-msk.arn
    encryption_in_transit {
      client_broker = var.msk_encryption_data_in_transit
      in_cluster    = true
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.es-msk.arn
    revision = aws_msk_configuration.es-msk.latest_revision
  }
}
