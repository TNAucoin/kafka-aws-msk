deployEs: deployvpc deploymsk
destroyEs: destroymsk destroyvpc

deployvpc:
	@echo Init ES VPC
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform
	(cd aws-infrastructure/deployment/es-vpc; terraform init -backend-config="../../configuration/terraform-backend.tfvars")
	(cd aws-infrastructure/deployment/es-vpc; terraform apply -auto-approve -var-file="../../configuration/global-config.tfvars")
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform

destroyvpc:
	@echo Destroying ES VPC
	(cd aws-infrastructure/deployment/es-vpc; terraform init -backend-config="../../configuration/terraform-backend.tfvars")
	(cd aws-infrastructure/deployment/es-vpc; terraform destroy -auto-approve -var-file="../../configuration/global-config.tfvars")
	rm -rf aws-infrastructure/deployment/es-vpc/.terraform

deploymsk:
	@echo Initializing MSK
	rm -rf aws-infrastructure/deployment/es-msk/.terraform
	(cd aws-infrastructure/deployment/es-msk; terraform init -backend-config="../../configuration/terraform-backend.tfvars")
	(cd aws-infrastructure/deployment/es-msk; terraform apply -auto-approve -var-file="../../configuration/global-config.tfvars" -var-file="../../configuration/msk-config.tfvars")
	rm -rf aws-infrastructure/deployment/es-msk/.terraform

destroymsk:
	@echo Destroying MSK
	(cd aws-infrastructure/deployment/es-msk; terraform init -backend-config="../../configuration/terraform-backend.tfvars")
	(cd aws-infrastructure/deployment/es-msk; terraform destroy -auto-approve -var-file="../../configuration/global-config.tfvars" -var-file="../../configuration/msk-config.tfvars")
	rm -rf aws-infrastructure/deployment/es-msk/.terraform