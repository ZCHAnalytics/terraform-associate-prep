
# 
## CLI login
## Credentials Variable Setup
## Workspace setup for CLI-driven runs
- configure terraform.tf
- terraform init

- Assign variable set to workspace

## Create infrastructure

- Configure Terraform variables

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/4dbae4b4-275e-45dc-a8f3-78334122536d)

'tf-cloud' workspace is now configured with 2 workspace-specific input variables and uses the AWS Credentials variable set.

- Apply planned changes
  
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c048b48d-9a23-45ff-bf82-a78fda463635)

We created an AWS EC2 instance using Terraform Cloud. Verify that the infrastructure exists:

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c04670e7-7142-412e-a590-f22b77e25717)
