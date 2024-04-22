![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/48828b1e-cdd7-4289-8924-cde98f188196)

## Prerequisites
- Terraform v1.6+ installed locally.
- An AWS account with local credentials configured for use with Terraform.
- The jq command line utility.
- Clone of the example repository.
- Terraform configuration initialised.

## Create a plan
```hcl
$ terraform plan -out "tfplan"
```
Terraform created a plan and saved it in the tfplan file.

During plan creation, Terraform checks the workspace for an existing state file. Since we have not yet applied this configuration, the workspace's state is empty, and Terraform plans to create all of the resources defined in the configuration. We can apply the saved plan file to execute these changes, but the contents of the plan are not in a human-readable format. Use the terraform show command to print out the saved plan.
```hcl
$ terraform show "tfplan"
```

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/83a7b6b9-e042-4162-a040-e95529b572b6)

Terraform can also report the contents of the saved plan as JSON. This is often useful when using Terraform in automated pipelines, as we can use code to inspect the plan. We convert the saved plan into JSON, pass it to jq to format it, and save the output into a new file.
```hcl
$ terraform show -json "tfplan" | jq > tfplan.json
```

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/fb3ca5c5-9058-4ab0-88ba-ef5612268650)

### Warning
Terraform plan files can contain sensitive data. Never commit a plan file to version control, whether as a binary or in JSON format.

## Review the plan
Terraform records the version of Terraform used to generate the plan, and the version of the plan file format. This ensures that we use the same version to apply these changes when we use the saved plan.
```hcl
$ jq '.terraform_version, .format_version' tfplan.json
```

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/72985d06-4830-42af-ab7e-22b42460830c)

## Review plan configuration
This configuration snapshot captures the versions of the providers recorded in the .terraform.lock.hcl file, ensuring that we use the same provider versions that generated the plan to apply it. Note that the configuration accounts for both the provider version used by the root module and child modules. The configuration section further organizes the resources defined in the top level root_module. The module_calls section contains the details of the modules used, their input variables and outputs, and the resources to create.

The configuration object also records any references to other resources in a resource's written configuration, which helps Terraform determine the correct order of operations when it applies the plan.

## Review planned resource changes
Review the planned resources changes to the aws_instance resource from the ec2-instance local module. The representation includes:
- The action field captures the action taken for this resource, in this case create.
- The before field captures the resource state prior to the run. In this case, the value is null because the resource does not yet exist.
- The after field captures the state to define for the resource.
- The after_unknown field captures the list of values that will be computed or determined through the operation and sets them to true.
- The before_sensitive and after_sensitive fields capture a list of any values marked sensitive. Terraform will use these lists to determine which output values to redact when we apply our configuration.

## Review planned values
The planned_values object is a report of the differences between the "before" and "after" values of your resources, showing you the planned outcome for a run that would use this plan file.

## Apply a saved plan
```hcl
$ terraform apply "tfplan"
```
## Modify configuration
Input variables allows to easily update configuration values without having to edit the configuration files. In the variables.tf file in the top-level configuration directory, we add the configuration to define a new input variable to use for the hello module. Then, create a terraform.tfvars file, and set the new secret_key input variable value. Finally, update the hello module configuration in main.tf to reference the new input variable.

### Warning
Never commit .tfvars files to version control.

## Create a new plan
We create a new Terraform plan and save it as tfplan-input-var.
```hcl
$ terraform plan -out "tfplan-input-var"
```
We convert the new plan file into a machine-readable JSON format.
```hcl
$ terraform show -json tfplan-input-var | jq > tfplan-input-var.json
```
## Review new plan
When we created this plan, Terraform determined that the working directory already contains a state file, and used that state to plan the resource changes.
Since Terraform created this plan with existing resources and using input variables, our plan file has some new fields.
```jq
jq '.terraform_version, .format_version' tfplan.json
jq '.configuration.provider_config' tfplan.json
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f27b5668-871a-4718-a5cf-fb18fdfd413f)

## Apply the saved plan
```hcl
$ terraform apply "tfplan"
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/a42b52d7-5157-40ae-9483-7a2cb1b1de55)

## Review plan resource changes
Now that the state file tracks resources, Terraform will take the existing state into consideration when it creates an execution plan. For example, the module.hello.random_pet.server object now contains data in both the before and after fields, representing the prior and desired configurations respectively. The actions list is now set to ["delete","create"] and that the action_reason is "replace_because_cannot_update" - the change to the secret_key for the resource is destructive, so Terraform must both delete and create this resource. Terraform determines whether it can update a resource in place or must recreate it based on which provider attributes we changed.

## Clean up infrastructure
Now we destroy the resources created before moving on.
```hcl
$ terraform plan -destroy -out "tfplan-destroy"
```
When we use the -destroy flag, Terraform creates a plan to destroy all of the resources in the configuration. We apply the plan to destroy the resources. The terraform destroy command is a shortcut that creates a destroy plan and then waits for approval. Saving a destroy plan allows us to review it before applying, just like a regular saved plan. 
```hcl
$ terraform apply "tfplan-destroy"
```
