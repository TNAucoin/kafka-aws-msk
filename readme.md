
Required Env File Configuration:

```
TF_VAR_terraform_deployment_bucket=<bucket name for terraform deployments>
TF_VAR_profile=<profile name for aws cli>
TF_VAR_region=<aws region to deploy to>
TF_VAR_ip=<computer's local ip>
```

Deployment Process:
A makefile is included to simplify the deployment process. Make sure the required .env file is present before deployment.

To Deploy:
```
make deployEs
```
To Destroy:
```
make destroyEs
```
