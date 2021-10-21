resource "aws_security_group" "es-ecs-application-lb" {
  name   = "es-ecs-application-lb"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.machine_public_ip_address]
    description = "Machine public IP address"
  }
  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "es-ecs-application-lb" {
  name               = "es-ecs-application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.es-ecs-application-lb.id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "es-ecs-kafka-schema-registry-ui" {
  name       = "es-ecs-kafka-schema-registry-ui"
  port       = var.ecs_host_kafka_schema_registry_ui_port
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  depends_on = [aws_lb.es-ecs-application-lb]
}

resource "aws_lb_listener" "es-ecs-kafka-schema-registry-ui" {
  load_balancer_arn = aws_lb.es-ecs-application-lb.arn
  port              = var.ecs_alb_kafka_schema_registry_ui_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es-ecs-kafka-schema-registry-ui.arn
  }
}

resource "aws_lb_target_group" "es-ecs-kafka-control-center" {
  name     = "es-ecs-kafka-control-center"
  port     = var.ecs_host_kafka_control_center_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  depends_on = [
    aws_lb.es-ecs-application-lb
  ]
}

resource "aws_lb_listener" "es-ecs-kafka-control-center" {
  load_balancer_arn = aws_lb.es-ecs-application-lb.arn
  port              = var.ecs_alb_kafka_control_center_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es-ecs-kafka-control-center.arn
  }
}

resource "aws_lb_target_group" "es-ecs-kafka-connect-ui" {
  name       = "es-ecs-kafka-connect-ui"
  port       = var.ecs_host_kafka_connect_ui_port
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  depends_on = [aws_lb.es-ecs-application-lb]
}

resource "aws_lb_listener" "es-ecs-kafka-connect-ui" {
  load_balancer_arn = aws_lb.es-ecs-application-lb.arn
  port              = var.ecs_alb_kafka_connect_ui_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es-ecs-kafka-connect-ui.arn
  }
}

resource "aws_lb_target_group" "es-ecs-kafka-rest-api" {
  name       = "es-ecs-kafka-rest-api"
  port       = var.ecs_host_kafka_rest_api_port
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  depends_on = [aws_lb.es-ecs-application-lb]
}

resource "aws_lb_listener" "es-ecs-kafka-rest-api" {
  load_balancer_arn = aws_lb.es-ecs-application-lb.arn
  port              = var.ecs_alb_kafka_rest_api_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.es-ecs-kafka-rest-api.arn
  }
}
