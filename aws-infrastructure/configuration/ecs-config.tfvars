
/*
Amazon ECS-optimized AMI. (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)
*/
ecs_image_id = "ami-0eba366342cb1dfda"


#ECS
ecs_cluster_name               = "es-ecs"
ecs_instance_type              = "t2.xlarge"
ecs_desired_capacity           = 2
ecs_min_size                   = 1
ecs_max_size                   = 2
image_kafka_schema_registry    = "confluentinc/cp-schema-registry:5.3.0"
image_kafka_schema_registry_ui = "landoop/schema-registry-ui:0.9.4"
image_kafka_connect            = "debezium/connect:0.9"
image_kafka_connect_ui         = "landoop/kafka-connect-ui"
image_kafka_rest_api           = "confluentinc/cp-kafka-rest:latest"
image_kafka_control_center     = "confluentinc/cp-enterprise-control-center:6.2.1"

ecs_container_kafka_schema_registry_port = 8081
ecs_host_kafka_schema_registry_port      = 8081

ecs_container_kafka_connect_port = 8083
ecs_host_kafka_connect_port      = 8083

ecs_alb_kafka_schema_registry_ui_port       = 9000
ecs_container_kafka_schema_registry_ui_port = 8000
ecs_host_kafka_schema_registry_ui_port      = 8001

ecs_alb_kafka_connect_ui_port       = 9001
ecs_container_kafka_connect_ui_port = 8000
ecs_host_kafka_connect_ui_port      = 8002

ecs_alb_kafka_rest_api_port       = 9002
ecs_container_kafka_rest_api_port = 8082
ecs_host_kafka_rest_api_port      = 8082

ecs_alb_kafka_control_center_port       = 9003
ecs_container_kafka_control_center_port = 9021
ecs_host_kafka_control_center_port      = 9021
