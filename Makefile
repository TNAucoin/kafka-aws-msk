include .env

deployEs: deployvpc deploymsk deployecs
destroyEs: destroyecs destroymsk destroyvpc 

define setup_env
        $(eval ENV_FILE := .env)
        @echo " - setup env from $(ENV_FILE)"
        $(eval include .env)
        $(eval export sed 's/=.*//' .env)
    endef

deployvpc:
	@echo Init ES VPC
	@echo $(TF_VAR_TERRAFORM_DEPLOYMENT_BUCKET)
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform
	(cd aws-infrastructure/deployment/es-vpc; terraform init -backend-config="bucket=${TF_VAR_terraform_deployment_bucket}" -backend-config="region=${TF_VAR_region}" -backend-config="profile=${TF_VAR_profile}")
	(cd aws-infrastructure/deployment/es-vpc; terraform apply -auto-approve -var="terraform_deployment_bucket=${TF_VAR_terraform_deployment_bucket}" -var="AWS_PROFILE=${TF_VAR_profile}" -var="aws_region=${TF_VAR_region}" -var="machine_public_ip_address=${TF_VAR_ip}")
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform

destroyvpc:
	@echo Destroying ES VPC
	(cd aws-infrastructure/deployment/es-vpc; terraform init -backend-config="bucket=${TF_VAR_terraform_deployment_bucket}" -backend-config="region=${TF_VAR_region}" -backend-config="profile=${TF_VAR_profile}")
	(cd aws-infrastructure/deployment/es-vpc; terraform destroy -auto-approve -var="terraform_deployment_bucket=${TF_VAR_terraform_deployment_bucket}" -var="AWS_PROFILE=${TF_VAR_profile}" -var="aws_region=${TF_VAR_region}" -var="machine_public_ip_address=${TF_VAR_ip}")
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform

deploymsk:
	@echo Initializing MSK
	
	rm -rf aws-infrastructure/deployment/es-msk/.terraform
	(cd aws-infrastructure/deployment/es-msk; terraform init -backend-config="bucket=${TF_VAR_terraform_deployment_bucket}" -backend-config="region=${TF_VAR_region}" -backend-config="profile=${TF_VAR_profile}")
	(cd aws-infrastructure/deployment/es-msk; terraform apply -auto-approve -var-file="../../configuration/msk-config.tfvars" -var="terraform_deployment_bucket=${TF_VAR_terraform_deployment_bucket}" -var="aws_profile=${TF_VAR_profile}" -var="aws_region=${TF_VAR_region}" -var="machine_public_ip_address=${TF_VAR_ip}")
	rm -rf aws-infrastructure/deployment/es-msk/.terraform

destroymsk:
	@echo Destroying MSK
	(cd aws-infrastructure/deployment/es-msk; terraform init -backend-config="bucket=${TF_VAR_terraform_deployment_bucket}" -backend-config="region=${TF_VAR_region}" -backend-config="profile=${TF_VAR_profile}")
	(cd aws-infrastructure/deployment/es-msk; terraform destroy -auto-approve -var-file="../../configuration/msk-config.tfvars" -var="terraform_deployment_bucket=${TF_VAR_terraform_deployment_bucket}" -var="aws_profile=${TF_VAR_profile}" -var="aws_region=${TF_VAR_region}" -var="machine_public_ip_address=${TF_VAR_ip}")
	rm -rf aws-infrastructure/deployment/es-msk/.terraform

deployecs:
	@echo Initializing ECS
	rm -rf aws-infrastructure/deployment/kad-ecs/.terraform
	(cd aws-infrastructure/deployment/es-ecs; terraform init -backend-config="bucket=${TF_VAR_terraform_deployment_bucket}" -backend-config="region=${TF_VAR_region}" -backend-config="profile=${TF_VAR_profile}")
	(cd aws-infrastructure/deployment/es-ecs; terraform apply -auto-approve -var-file="../../configuration/ecs-config.tfvars" -var="ecs_key_name=${TF_VAR_ecs_key_name}" -var="terraform_deployment_bucket=${TF_VAR_terraform_deployment_bucket}" -var="aws_profile=${TF_VAR_profile}" -var="aws_region=${TF_VAR_region}" -var="machine_public_ip_address=${TF_VAR_ip}")
	rm -rf aws-infrastructure/deployment/kad-ecs/.terraform