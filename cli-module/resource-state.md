![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/059c54f2-5e38-40eb-a414-c0b80ded7476)

Our configuration uses the AWS provider to create an EC2 instance and a security group that allows public access.

## Create infrastructure and state

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/dc585add-b939-456b-8548-7d6045e53d91)

## Examine State with CLI
Run `terraform show` to get a human-friendly output of the resources contained in the state or `terraform state list` to get the list of resource names and local identifiers in the state file.
```hcl
$ terraform show
$ terraform state list
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/214fabb2-deb5-4842-964e-ea9c4400b25b)

## Replace a resource with CLI
Terraform usually only updates the infrastructure if it does not match the configuration. The flag `-replace` can be used to plan and apply operations to safely recreate resources in our environment even if we have not edited the configuration. 
```hcl
$ terraform apply -replace="aws_instance.example"
```
As shown in the output, when change is aplied, Terraform will destroy the running instance and create a new one.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/ef7e5495-e5fb-4f78-9150-e8c6165056bc)

## Move a resource to a different state file
Some of the Terraform state subcommands are useful in very specific situations. HashiCorp recommends only performing these advanced operations as the last resort.
The new_state subdirectory contains a new Terraform configuration. This configuration creates a new EC2 instance named aws_instance.example_new and uses a data resource to use the same security group from the root configuration file. 
Now, we have a second state file with a managed resource and a data source.

Move the new EC2 instance resource we just created, aws_instance.example_new, to the old configuration's file in the directory above the current location, as specified with the -state-out flag. Set the destination name to the same name, since in this case there is no resource with the same name in the target state file.
```hcl
$ cd new_state
$ terraform init
$ terraform apply
$ terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/72d6b971-0ca8-49f2-a3e2-cbba80ce7642)

Change back into the root directory and run `terraform state list` to confirm that the new EC2 instance, aws_instance.example_new, is present in the in original configuration's state file.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/74638a62-ddd0-4c8e-ac81-52bf2f432fc8)

Without adding the EC2 resource we moved to the configuration files, we create a Terraform plan. Because the new EC2 instance is present in state but not in the configuration, Terraform plans to destroy the moved instance, and remove the resource from the state file.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/20808ad9-e975-497f-aa04-b19fdb58cc75)

We open the main.tf file in the root directory to copy and paste the resource definition below:
```hcl
resource "aws_instance" "example_new" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_8080.id]
  user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags = {
    Name = "terraform-learn-state-ec2"
  }
}
```
After applying a new configuration, it will match the state file and Terraform will not perform any changes.

We change into the new_state directory and run terraform destroy and we should have no resources to destroy. 
Our security_group resource is a data source and the aws_instance resource was moved to another state file. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/97c9ab88-e874-475d-9096-571fff60fd7f)

## Remove a resource from state
We use a removed block to remove specific resources from the state. This does not destroy the infrastructure itself, instead it indicates that the Terraform configuration will no longer manage the resource.
We change into the root directory and remove the aws_instance.example_new from the project's state. We comment out the entire resource "aws_instance" "example_new" block from main.tf and add a removed block to instruct Terraform to remove the resource from state, but not destroy it.

Apply and confirm the change by reviewing the state list. The aws_instance.example_new resource does not exist in the project's state, but the resource still exists in the AWS account.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/6a506ad2-ef26-44d2-a78d-40180b67512f)

Import the instance back into the project. First, uncomment the aws_instance.example_new block, and comment out the removed block added in the previous step.Run terraform import to bring this instance back into the state file. 
```hcl
$ terraform import aws_instance.example_new <INSTANCE_ID>
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/0ecd8a89-b06e-43df-93ef-e6783e10e2e3)

## Refresh modified infrastructure
Delete the original EC2 instance from the AWS account to create a difference between the state and the real-world resources mapped to it. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/790e365c-d321-40c7-8103-acc585b5dc26)

The terraform refresh command updates the state file when physical resources change outside of the Terraform workflow. 
```hcl
$ terraform refresh
$ terraform state list
```
The state file now reflects reality. The terraform refresh command does not update the configuration file. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/13ce8e19-e795-4952-bd3c-42ffb7797986)

We plan the changes. Remove the original aws_instance.example resource from main.tf and the output values that reference the instance in the outputs.tf. 
We then apply the configuration, which will confirm that Terraform changed the outputs and did not destroy any infrastructure.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/9c53e979-ecc4-4060-b710-77c3ed7d0d72)

## Destroy infrastructure
Terraform also updates the state file when `terraform destroy` operation runs.
The terraform.tfstate file still exists, but does not contain any resources. The terraform show can be used to confirm that the state file is empty. 
