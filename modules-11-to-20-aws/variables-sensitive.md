![alt text](image.png)

We will use Terraform to deploy a web application on AWS, including a VPC, load balancer, EC2 instances, and a database. 

We will replace the database's hard-coded credentials with variables configured with the sensitive flag. We will set values for variables using environment variables and with a .tfvars file. Finally, we will identify the sensitive values in state, and learn about ways to protect the state file.

## Refactor database credentials
In the main.tf the database username and password are hard-coded. We will refactor this configuration to remove these values. 

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/602bc50c-6903-47da-93b4-3e6a498e6479)

First, we declare input variables as sensitive for the database administrator username and password in variables.tf. 

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/16485ce0-135e-49ef-a070-f41d29208666)

Then, we update main.tf to reference these variables.

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/3c7744c8-3540-4570-bceb-16b518929305)

We can use two different methods to set the sensitive variable values.

### Option 1. Set values with a .tfvars file
  
We create a new file called secret.tfvars to assign values to the new variables.
```hcl
db_username = "admin"
db_password = "insecurepassword"
```
We apply these changes using the `-var-file` parameter. 
```hcl
$ terraform apply -var-file="secret.tfvars"
```
Oh, no, we get an error:

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/bdc633f7-6584-42c1-8608-ecd6968f9f27)

After trial and error, we can settle on instance type db.m5.large and it worked! 

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/ad2f6a52-e63a-4df4-9e12-0886ee5ad3df)

Terraform redacts the values of sensitive varibales from its output when its run a plan, apply, or destroy command. Notice that the password is marked sensitive value, while the username is marked sensitive. The AWS provider considers the password argument for any database instance as sensitive, whether or not it is declared the variable as sensitive, and will redact it as a sensitive value. 

Setting values with a .tfvars file separates sensitive values from the rest of variable values, and makes it clear to people working with the configuration which values are sensitive. We must also be careful not to check .tfvars files with sensitive values into version control. For this reason, GitHub's recommended .gitignore file for Terraform configuration is configured to ignore files matching the pattern *.tfvars.

### Option 2. Set values with variables
Set the database administrator username and password using environment variables for Terraform Community Edition or Terraform variables for HCP Terraform. 

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/6b2d8bbd-72a1-4ee2-99e9-feb9fb19247d)

Now, run terraform apply, and Terraform will assign these values to the new variables.

## Reference sensitive variables
Terraform redact sensitive values in command output and log files, and raise an error when it detects that they will be exposed in other ways. For instance, if we try to use a sensitive variable to produce an output in the outputs.tf file and apply the change, Terraform will raise an error, since the output is derived from sensitive variables.

```hcl
output "db_connect_string" {
  description = "MySQL database connection string"
  value       = "Server=${aws_db_instance.database.address}; Database=ExampleDB; Uid=${var.db_username}; Pwd=${var.db_password}"
}
```
Terrafrom explains the error and tells how to troubleshoot:

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/e2f3317c-facb-4f10-8326-94f16e469a0a)

So, we need to flag the database connection string output as sensitive, causing Terraform to hide it.

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/44d825c7-a272-4afa-8361-275a64e005cc)

Apply this change to see that Terraform will now redact the database connection string output. 

![image](https://github.com/ZCHAnalytics/terraform-associate-prep/assets/146954022/75574d30-17ea-42bc-b37d-68154ac8065e)
