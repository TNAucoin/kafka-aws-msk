provider "aws" {
  region  = var.aws_region
  profile = var.AWS_PROFILE
}

terraform {
  backend "s3" {
    key = "es-vpc/terraform.tfstate"
  }
}
