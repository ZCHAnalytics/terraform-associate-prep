![alt text](image.png)

We will use Terraform to deploy a web application on AWS, including a VPC, load balancer, EC2 instances, and a database. 

We will replace the database's hard-coded credentials with variables configured with the sensitive flag. We will set values for variables using environment variables and with a .tfvars file. Finally, we will identify the sensitive values in state, and learn about ways to protect the state file.
