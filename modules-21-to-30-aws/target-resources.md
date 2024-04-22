![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a79535cd-bf66-4cd5-b72d-e30ca67c5689)

In a typical Terraform workflow, you apply the entire plan at once. Occasionally you may want to apply only part of a plan, such as when Terraform's state has become out of sync with your resources due to a network failure, a problem with the upstream cloud platform, or a bug in Terraform or its providers. To support this, Terraform lets you target specific resources when you plan, apply, or destroy your infrastructure. 
You can use Terraform's -target option to target specific resources, modules, or collections of resources. After using resource targeting to fix problems with a Terraform project, be sure to apply changes to the entire configuration to ensure consistency across all resources. 

## Target the S3 bucket name

We create infrastructure with an S3 bucket with its name length (after a prefix) set to 3 strings separated by dash.
```bash
resource "random_pet" "bucket_name" {
  length    = 3
  separator = "-"
  prefix    = "learning"
}
```
We got the name: learning-reasonably-genuine-koala

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/97bfa101-4cb3-41df-ae6e-c159a1dc8347)

In main.tf, we update the value of  the length of the `random_pet.bucket_name` resource from 3 to 5 and then plan the change.

```hcl
$ terraform plan
```
Now, Terraform plans to change the random_pet resource along with any resources dependent on it.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/fc6860d5-7f39-464a-b9d1-499ba83ab686)

Plan the change again, but target only the random_pet.bucket_name resource.
```hcl
$ terraform plan -target="random_pet.bucket_name"
```
Terraform will plan to replace only the targeted resource.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/d2b2133f-04e0-42f1-b4c5-37b1353d7e43)

Now create a plan that targets the module, which will apply to all resources within the module.
```hcl
$ terraform plan -target="module.s3_bucket"
```
Terraform determines that module.s3_bucket depends on random_pet.bucket_name, and that the bucket name configuration has changed. Because of this dependency, Terraform will update both the upstream bucket name and the module you targeted for this operation. Resource targeting updates resources that the target depends on, but not resources that depend on it.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/82060b3d-1de6-4b15-90b8-58f4a9e98613)

Apply the change to only the bucket name. 
```hcl
$ terraform apply -target="random_pet.bucket_name"
```
The bucket_name output changes, and no longer matches the bucket ARN.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a60007de-7485-4116-b6ea-6a29cc2ca51d)

When using Terraform's normal workflow and applying changes to the entire working directory, the bucket name modification would apply to all downstream dependencies as well. 
Because you targeted the random pet resource, Terraform updated the output value for the bucket name but not the bucket itself. 

Update the bucket_name output to refer to the actual bucket name.
```hcl
output "bucket_name" {
  description = "Randomly generated bucket name."
  value       = module.s3_bucket.s3_bucket_id
}
```
The existing resources do not match either the original configuration or the new configuration. We need to apply changes to the entire working directory to make Terraform update the infrastructure to match the current configuration, including the change to the bucket_name output.
```hcl
$ terraform apply
```
Now, the bucket name and bucket ARN match: :) 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/ab40e22c-dad4-47b1-b878-60c88a50d5ce)


## Target specific bucket objects

We can pass multiple -target options to target several resources at once. After slightly modifying the main.tf file, we apply the change to two of the bucket object.
```hcl
$ terraform apply -target="aws_s3_object.objects[2]" -target="aws_s3_object.objects[3]"
```
Terraform updated the selected bucket objects.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/8d57599e-cbb6-4ed6-8c01-3ecb27d9afcd)

## Destroy target infrastructure
Terraform's destroy command also accepts resource targeting. 
```hcl
$ terraform destroy -target="aws_s3_object.objects"
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/4c3c0a15-c207-467d-9634-f66c2d359ceb)


Now destroy the rest of the infrastructure.
