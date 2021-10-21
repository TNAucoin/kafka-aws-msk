resource "aws_ecs_service" "es-kafka-schema-registry" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-kafka-schema-registry"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-kafka-schema-registry.arn

  service_registries {
    registry_arn   = aws_service_discovery_service.es-kafka-schema-registry.arn
    container_name = "es-kafka-schema-registry"
  }

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = false
    security_groups  = [aws_security_group.es-ecs.id]
  }
}

resource "aws_ecs_service" "es-kafka-connect" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-kafka-connect"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-kafka-connect.arn

  service_registries {
    registry_arn   = aws_service_discovery_service.es-kafka-connect.arn
    container_name = "es-kafka-connect"
  }

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = false
    security_groups  = [aws_security_group.es-ecs.id]
  }
}

resource "aws_ecs_service" "es-ecs-kafka-schema-registry-ui" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-ecs-kafka-schema-registry-ui"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-ecs-kafka-schema-registry-ui.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.es-ecs-kafka-schema-registry-ui.arn
    container_name   = "es-ecs-kafka-schema-registry-ui"
    container_port   = var.ecs_container_kafka_schema_registry_ui_port
  }
}

resource "aws_ecs_service" "es-ecs-kafka-connect-ui" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-ecs-kafka-connect-ui"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-ecs-kafka-connect-ui.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.es-ecs-kafka-connect-ui.arn
    container_name   = "es-ecs-kafka-connect-ui"
    container_port   = var.ecs_container_kafka_connect_ui_port
  }
}

resource "aws_ecs_service" "es-ecs-kafka-rest-api" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-ecs-kafka-rest-api"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-ecs-kafka-rest-api.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.es-ecs-kafka-rest-api.arn
    container_name   = "es-ecs-kafka-rest-api"
    container_port   = var.ecs_container_kafka_rest_api_port
  }
}

resource "aws_ecs_service" "es-ecs-kafka-control-center" {
  cluster             = aws_ecs_cluster.es-ecs.id
  desired_count       = 1
  launch_type         = "EC2"
  name                = "es-ecs-kafka-control-center"
  scheduling_strategy = "REPLICA"
  task_definition     = aws_ecs_task_definition.es-ecs-kafka-control-center.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.es-ecs-kafka-control-center.arn
    container_name   = "es-ecs-kafka-control-center"
    container_port   = var.ecs_container_kafka_control_center_port
  }
}
