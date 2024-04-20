
# 
## CLI login
## Credentials Variable Setup
## Workspace setup for CLI-driven runs
- configure terraform.tf
- terraform init

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/4a9cfb1a-9cc0-4637-8108-1bb4934efe16)

- Assign variable set to workspace

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a4e99b47-db31-4a33-be87-9e69e9bfb9b3)

## Create infrastructure

- Configure Terraform variables
- 
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/4dbae4b4-275e-45dc-a8f3-78334122536d)

'Cloud' workspace is now configured with 2 workspace-specific input variables and uses the AWS Credentials variable set.
- Apply planned changes
Trggers a run:
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/fb2b5ebb-c045-43af-9b54-b1329d75ed75)
