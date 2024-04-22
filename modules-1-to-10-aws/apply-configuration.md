![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f513f076-4eb0-4ba8-a1f9-717ac52b3b7a)


## 1. Initialize and apply the configuration 
```hcl
$ terraform init
$ terraform apply
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/d05d8b31-6d95-4c68-9cb1-f00fd65774b4)

## 2. Error handling
Introduce an intentional error during an apply.
- Add the configuration to main.tf to create a new S3 object.
- Create a saved plan for the new configuration.
```hcl
$ terraform plan -out "add-object"
```

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/e741e8f9-fa8e-4192-aa08-6ba76de2144c)

- Check the bucket in AWS console.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f69d96a0-4c9b-4185-a773-5c4442a2e8c8)

- Remove the bucket

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/6445708e-5ca7-4006-8694-0615a06a94c9)

```hcl
$ terraform apply "add-object"
```

As the S3 bucket was removed after the plan was created, AWS was unable to create the object, so the AWS provider reported the error to Terraform.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/56060d06-5e5c-4e40-a252-8dd8a11ee2b9)


- Print out the state of the S3 bucket
  This command does not refresh the terraform state, so the information can be out of date. So the project's state reports the existence of the S3 bucket that was manually deleted earlier.
```hcl
$terraform show -json | jq '.values.root_module.resources[] | select( .address == "aws_s3_bucket.example")'
```

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c18197f2-365c-4162-9991-e3a6b45450f3)

- Apply the new configuration. Terraform will referesh the workspace's state to reflect the fact that the S3 bucket no longer exists. Next it will create a plan to reconcile the configuration with that state by creating both the S3 bucket and object.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a0eb882b-42d2-4014-8b3e-c63448186702)

## 3. Replace Resources
Use the `-replace` argument when a resource has become unhealthy or stops working in ways that are outside of Terraform's control. 
For instance, an error in the EC2 instance's OS configuration could require that the instance be replaced. There is no corresponding change to the rest of the Terraform configuration, so Terraform only needs to reprovision the resource using the same configuration. The `-replace` argument requires a resource address, so first, we list the resources.
```hcl
$ terraform state list
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/14fcd59a-9d51-49fc-a898-dcfdfffd8faf)

Then we replace the 'faulty' EC2 instance. 
```hcl
terraform apply -replace "aws_instance.main[1]"
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/d246a6bf-5480-476b-8fb1-6d82a5092ab1)

## 4. Clean up infrastructure

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/61abaa1d-6931-4798-8ee0-8e5ebfc3b8c1)
