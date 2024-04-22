![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/1ddec2ad-e122-4e1b-b379-0bca95ea57e0)

In this scenario, we use Terraform to deploy a web application on AWS. The supporting infrastructure includes a VPC, load balancer, and EC2 instances. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f52c8713-6e9c-4214-b155-23ed67c0ca1e)

We will parameterize this configuration with the following types of input variables.
type        = map(string)
type        = list(string) with slice() function 
type        = string
type        = number
type        = bool

In the variables.tf file, we will declare the variables and then update the main.tf files to replace hard-coded values with newly created variables. 

## Use simple string variables

In variables.tf we declare a string type variables named aws_region and the vpc_cidr_block.

If we apply the updated configuration, there will be no change since the default values of these variables are the same as the hard-coded values they replaced.
  `terraform apply`

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/50a8e948-9ab1-4067-add1-11c7f4129460)

And we test the weblink to the app:

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/244683a2-13c7-4c3c-8be0-8021870c9390)

## Use a number variable to set the number of instances
type        = number

## Use a boolean variable to toggle VPN gateway support
Use a bool type variable to control whether to configure a VPN gateway for the VPC. 

  enable_vpn_gateway = var.enable_vpn_gateway # Add boolean variable

## Use list collection variable and slice() function to list subnets

We will use list variables to set the private_subnets and public_subnets arguments for the VPC. 

In our variables.tf file, the count of subnets is currently set to 2.
Users can specify a different number for the set of public and private subnets they want without worrying about defining CIDR blocks. These subsets will be then extracted with slice() function. 

private_subnets = slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count) 
public_subnets  = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count) 

## Map resource tags

Each of the resources and modules declared in main.tf includes two tags: project_name and environment. Assign these tags with a map variable type.

  `terraform apply`

No changes applied, again!

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a7664282-7169-4948-abf7-26685ac77c26)

## Assign values to variables
Terraform requires a value for every variable. There are several ways to assign variable values.

### Use command line flag `-var`
In the examples so far, all of the variable definitions have included a default value. Add a new variable without a default value to variables.tf.

terraform apply -var ec2_instance_type=t2.micro

Apply this configuration now, using the -var command line flag to set the variable value. Since the value you entered is the same as the old value, there will be no changes to apply.

### Assign values with a file terraform.auto.tfvars

Entering variable values manually is time consuming and error prone. Instead, they can be captured in a file. Terraform automatically loads all files in the current directory with the exact name terraform.tfvars or matching *.auto.tfvars. 
After the configuration with new values is applied, Terraform will highlight the changes and ask for the confirmation to perform the plan.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/0416a948-19da-4749-afd4-54fcbc66b357)

## Interpolate variables in strings
Terraform configuration supports string interpolation — inserting the output of an expression into a string. 

Update the names of the security groups to use the project and environment values from the resource_tags map.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/fc7f4187-81fd-4533-8900-74936964b60b)

## Use variable validation to restrict the values 

AWS restricts names of load balancers be no more than 32 characters long and only contain a limited set of characters.
Add validation blocks to enforce character limits and character sets on both project and environment values.
```
  validation {
    condition     = length(var.resource_tags["project"]) <= 16 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["project"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
  }

  validation {
    condition     = length(var.resource_tags["environment"]) <= 8 && length(regexall("[^a-zA-Z0-9-]", var.resource_tags["environment"])) == 0
    error_message = "The environment tag must be no more than 8 characters, and only contain letters, numbers, and hyphens."
  }
}
```
The regexall() function takes a regular expression and a string to test it against, and returns a list of matches found in the string. 
In this case, the regular expression will match a string that contains anything other than a letter, number, or hyphen.
This ensures that the length of the load balancer name does not exceed 32 characters, or contain invalid characters. 

We test the validation rules by specifying an environment tag that is too long. 
terraform apply -var='resource_tags={project="my-project",environment="development"}'

The command will fail and return the error message specified in the validation block.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/4c59ab05-64b1-4375-a652-1db5cedffd4a)

## Clean up infrastructure

terraform destroy
