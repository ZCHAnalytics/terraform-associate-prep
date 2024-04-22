# Initialize Terraform configuration

## Prerequisites
- Terraform v1.6+ installed locally.
- A Terraform Cloud account with Terraform Cloud locally authenticated.

## Clone the example repository


## Initialize your workspace

terraform.tf 

terraform init
- First, Terraform initializes the backend.
- Next, Terraform downloads the modules required by your configuration.
- Next, Terraform downloads the providers required by your configuration.
- Next, Terraform creates the lock file if it does not already exist, or updates it if necessary.
- Finally, Terraform prints out a success message and reminds you how to plan your configuration, and to re-run terraform init if you change your modules or backend configuration.
  
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/dc042f32-6a0f-4790-ba30-887d6b5cd90c)


## Validate your configuration

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/f60e07e1-7bbe-41aa-ab60-6730d7f02474)


## Explore the `.terraform` directory

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/c215f0dc-2e32-49bc-8fe7-7c984de1fa21)


## Update provider and module versions

In terraform.tf, update the random provider's version to 3.5.1.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/59d86f47-5ce7-4c96-8080-de6b316dc51e)


In main.tf, update the hello module's version to 6.0.0.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/b82f70a8-e56f-4b1e-bd96-fc2cf3698bc9)


## Reinitialize configuration

```hcl
$ terraform init
```

Notice that Terraform downloaded the updated module version and saved it in .terraform/modules/hello. However, Terraform was unable to update the provider version since the new provider version conflicts with the version found in the lock file.

Re-initialize the configuration with the `-upgrade` flag. This tells Terraform to upgrade the provider to the most recent version that matches the version attribute in that provider's required_version block.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/74317603-5525-49e4-a658-d9dc47e08447)

```hcl
$ terraform init -upgrade
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/82c8c6b7-8abe-4fec-8243-59c10abee7e1)

View the .terraform/providers directory structure. Notice that Terraform installed the updated random provider version 3.5.1.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/9ad1a2b9-41c7-4e89-9213-1635805d06c4)

In the lock file the random provider now uses version 3.5.1. Even though there are two versions of the random provider in .terraform/providers, Terraform will always use the version recorded in the lock file.

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/15106258-bede-4326-a09a-78c54da50afd)

## Update module arguments

Since we have updated our provider and module version, we check whether our configuration is still valid.
```hcl
$ terraform validate
```
![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/6fe166f9-ecd1-4509-8ed5-605e64147c3d)

The new version of the hello module expects different arguments from the old version. Replace the entire module "hello" block with the following:

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/7f727bd9-7fbd-4ffc-8b96-f4506f9b1ec5)

Re-validate our configuration.
