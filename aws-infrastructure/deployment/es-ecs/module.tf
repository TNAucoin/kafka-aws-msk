data "terraform_remote_state" "es-vpc" {
  backend = "s3"
  config = {
    bucket  = "${var.terraform_deployment_bucket}"
    key     = "es-vpc/terraform.tfstate"
    region  = "${var.aws_region}"
    profile = "${var.aws_profile}"
  }
}

data "terraform_remote_state" "es-msk" {
  backend = "s3"
  config = {
    bucket  = "${var.terraform_deployment_bucket}"
    key     = "es-msk/terraform.tfstate"
    region  = "${var.aws_region}"
    profile = "${var.aws_profile}"
  }
}

module "es-ecs" {
  source                    = "../../modules/es-ecs"
  msk_bootstrap_brokers     = data.terraform_remote_state.es-msk.outputs.msk-bootstrap-brokers
  machine_public_ip_address = var.machine_public_ip_address
  vpc_id                    = data.terraform_remote_state.es-vpc.outputs.es-vpc
  subnet_ids                = ["${data.terraform_remote_state.es-vpc.outputs.es-public-subnet-a}", "${data.terraform_remote_state.es-vpc.outputs.es-public-subnet-b}", "${data.terraform_remote_state.es-vpc.outputs.es-public-subnet-c}"]
  ecs_cluster_name          = var.ecs_cluster_name
  ecs_instance_type         = var.ecs_instance_type
  ecs_image_id              = var.ecs_image_id
  ecs_key_name              = var.ecs_key_name
  ecs_desired_capacity      = var.ecs_desired_capacity
  ecs_min_size              = var.ecs_min_size
  ecs_max_size              = var.ecs_max_size

  ecs_container_kafka_schema_registry_port = var.ecs_container_kafka_schema_registry_port
  ecs_host_kafka_schema_registry_port      = var.ecs_host_kafka_schema_registry_port

  ecs_container_kafka_connect_port = var.ecs_container_kafka_connect_port
  ecs_host_kafka_connect_port      = var.ecs_host_kafka_connect_port

  ecs_alb_kafka_schema_registry_ui_port       = var.ecs_alb_kafka_schema_registry_ui_port
  ecs_container_kafka_schema_registry_ui_port = var.ecs_container_kafka_schema_registry_ui_port
  ecs_host_kafka_schema_registry_ui_port      = var.ecs_host_kafka_schema_registry_ui_port

  ecs_alb_kafka_connect_ui_port       = var.ecs_alb_kafka_connect_ui_port
  ecs_container_kafka_connect_ui_port = var.ecs_container_kafka_connect_ui_port
  ecs_host_kafka_connect_ui_port      = var.ecs_host_kafka_connect_ui_port

  ecs_alb_kafka_rest_api_port       = var.ecs_alb_kafka_rest_api_port
  ecs_container_kafka_rest_api_port = var.ecs_container_kafka_rest_api_port
  ecs_host_kafka_rest_api_port      = var.ecs_host_kafka_rest_api_port

  ecs_alb_kafka_control_center_port       = var.ecs_alb_kafka_control_center_port
  ecs_container_kafka_control_center_port = var.ecs_container_kafka_control_center_port
  ecs_host_kafka_control_center_port      = var.ecs_host_kafka_control_center_port


  image_kafka_schema_registry    = var.image_kafka_schema_registry
  image_kafka_schema_registry_ui = var.image_kafka_schema_registry_ui
  image_kafka_connect            = var.image_kafka_connect
  image_kafka_connect_ui         = var.image_kafka_connect_ui
  image_kafka_rest_api           = var.image_kafka_rest_api
  image_kafka_control_center     = var.image_kafka_control_center

}
