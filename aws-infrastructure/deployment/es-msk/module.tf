data "terraform_remote_state" "es-vpc" {
  backend = "s3"
  config = {
    bucket  = var.terraform_deployment_bucket
    key     = "es-vpc/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}

module "es-msk" {
  source                         = "../../modules/es-msk"
  vpc_id                         = data.terraform_remote_state.es-vpc.outputs.es-vpc
  msk_instance_type              = var.msk_instance_type
  subnet_ids                     = ["${data.terraform_remote_state.es-vpc.outputs.es-public-subnet-a}", "${data.terraform_remote_state.es-vpc.outputs.es-public-subnet-b}"]
  msk_kafka_version              = var.msk_kafka_version
  msk_number_of_brokers          = var.msk_number_of_brokers
  msk_ebs_volume_size            = var.msk_ebs_volume_size
  msk_encryption_data_in_transit = var.msk_encryption_data_in_transit
  msk_min_in_sync_replicas       = var.msk_min_in_sync_replicas
  msk_default_replication_factor = var.msk_default_replication_factor
  msk_configuration_name         = var.msk_configuration_name
}
