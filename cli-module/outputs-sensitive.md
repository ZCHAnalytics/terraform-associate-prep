![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/0cdc5d85-db6a-46ba-b1c2-473fa23e5c25)

## Output VPC and load balancer information

In the separate output.tf file, we add the following code:
```
output "vpc_id" {
  description = "ID of project VPC"
  value       = module.vpc.vpc_id
}

output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${module.elb_http.elb_dns_name}/"
}

output "web_server_count" {
  description = "Number of web servers provisioned"
  value       = length(module.ec2_instances.instance_ids)
}
```
We add a block to show the ID of the VPC and the definitions for lb.url and web_server_count. The `lb_url` output uses string interpolation to create a URL from the load balancer's domain name. 
The `web_server_count` output uses the length() function to calculate the number of instances attached to the load balancer.

Terraform stores output values in the configuration's state file. In order to see these outputs, we need to update the state by applying this new configuration, even though the infrastructure will not change.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/5420b67b-d757-416f-beba-b457c94592b1)

## Query outputs

We can then qury all the outputs:

  `terraform output`

or an individual output by name:

  `terraform output lb_url` 

  `terraform output -raw lb_url` # using a flag for a machine-readable format, without quotes. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c7f5652f-2446-45ec-86d0-7a8e535aff58)

Use the lb_url output value with the -raw flag to cURL the load balancer and verify the response.

  `curl $(terraform output -raw lb_url)`

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c599c50b-9dee-4488-955e-56afd72ca431)

## Redact sensitive outputs
Terraform will redact sensitive outputs when planning, applying, or destroying your configuration, or when all of the outputs are quered. Terraform will not redact sensitive outputs in other cases, such as when we query a specific output by name, query all of the outputs in JSON format, or when we use outputs from a child module in the root module.
We add the following output blocks to the `outputs.tf` file. 

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c4e86022-8295-40c8-a1cb-394f86450a62)

As a result, the `terraform apply` command does not change the infrastructure but changes how the outputs are printed in the console:

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a0a1f220-622d-4604-86c0-e924a8da9128)

However, if we query the database password by name, Terraform will not redact the value.
  `terraform output db_password`

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/9351897c-0ebc-4d45-81a1-658cda441cf9)

Pull down the remote state file from Terraform Cloud and use `grep` command to see the values of the sensitive outputs.
  `terraform state pull > terraform.tfstate`

  `grep --after-context=10 outputs terraform.tfstate`

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/e436b233-3f83-4530-8e77-3205853f2e30)

## Generate machine-readable output

The Terraform CLI output is designed to be parsed by humans. To get machine-readable format for automation, use the -json flag for JSON-formatted output.

  `terraform output -json`
  
Terraform does not redact sensitive output values with the -json option, because it assumes that an automation tool will use the output.

## Clean up infrastructure and workspace!
