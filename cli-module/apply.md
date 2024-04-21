

## Initialize your configuration

terraform.tf

terraform init

## Apply configuration

terraform apply

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/51653ee6-f0dd-46e3-b2e4-c8423968e28f)

## test how Terraform handles errors
Introduce an intentional error during an apply.
- Add the configuration to main.tf to create a new S3 object.

- 
terraform plan -out "add-object"

- remove the bucket

aws s3 rb s3://$(terraform output -raw bucket_name)
