

## Initialize your configuration

terraform.tf

terraform init
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/0a1aa01f-1135-4289-be46-6b654d55dcfd)


## Apply configuration

terraform apply

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/d05d8b31-6d95-4c68-9cb1-f00fd65774b4)

## Error handling
Introduce an intentional error during an apply.
- Add the configuration to main.tf to create a new S3 object.
- Create a saved plan for the new configuration.

terraform plan -out "add-object"
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/e741e8f9-fa8e-4192-aa08-6ba76de2144c)

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f69d96a0-4c9b-4185-a773-5c4442a2e8c8)

- remove the bucket
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/6445708e-5ca7-4006-8694-0615a06a94c9)

terraform apply "add-object"
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/56060d06-5e5c-4e40-a252-8dd8a11ee2b9)

Because you removed the S3 bucket after you created the plan, AWS was unable to create the object, so the AWS provider reported the error to Terraform.

- Print out the state of your S3 bucket
terraform show -json | jq '.values.root_module.resources[] | select( .address == "aws_s3_bucket.example")'

This command does not refresh your state, so the information in your state can be out of date. In this case, your project's state reports the existence of the S3 bucket you manually deleted earlier. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c18197f2-365c-4162-9991-e3a6b45450f3)

terraform apply

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a0eb882b-42d2-4014-8b3e-c63448186702)

## Replace Resources
Use the -replace argument when a resource has become unhealthy or stops working in ways that are outside of Terraform's control. For instance, an error in your EC2 instance's OS configuration could require that the instance be replaced. There is no corresponding change to your Terraform configuration, so you want to instruct Terraform to reprovision the resource using the same configuration.

The -replace argument requires a resource address. List the resources in your configuration with terraform state list.
terraform state list
terraform apply -replace "aws_instance.main[1]"

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/14fcd59a-9d51-49fc-a898-dcfdfffd8faf)

