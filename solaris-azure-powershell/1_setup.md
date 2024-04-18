# Build Infrastructure in Azure with Powershell
Pre-requisites:
- Azure account
- Azure CLI
- Terraform 0.14.9 or later //

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/34bd0931-0fbe-46c2-80d8-6b25474cb65c)



## 1. Authenticate using the Azure CLI
`az login`

## Using Azure account subscription ID, set the account with the Azure CLI
`az account set --subscription \"<SUBSCRIPTION_ID>`

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/abdbcd11-4574-41cc-a232-abf935dfa1da)

## Create a Service Principal

`az ad sp create-for-rbac --role=\"Contributor\" --scopes=\"/subscriptions/<SUBSCRIPTION_ID>`
    
## Set the environment variables using Service Principal output values

$Env:ARM_CLIENT_ID = \"<APPID_VALUE>\
$Env:ARM_CLIENT_SECRET = \"<PASSWORD_VALUE>\
$Env:ARM_SUBSCRIPTION_ID = \"<SUBSCRIPTION_ID>\
$Env:ARM_TENANT_ID = \"<TENANT_VALUE>\

## 2. Write Configuration

# Create a new directory in the current location
New-Item -Path "<>" -Name "learn-terraform-azure" -ItemType "directory"
```
# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}
```
## 3. Initialise Terraform, check format, validate syntax and apply

terraform init # initialise working directory

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/26033895-4ade-4ce6-8606-720b090199ce)

terraform fmt # check format
terraform validate # validate if the file has correct syntax
terraform apply # execute terraform plan

![image](https://github.com/ZCHAnalytics/terraform-modules/assets/146954022/903fda52-ece7-406c-a473-b862744a1073)

## 4. State Inspection

### Show content of terraform.tfstate file with the IDs and properties of all created resources

terraform show
