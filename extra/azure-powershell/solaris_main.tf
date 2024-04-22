# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0" # version must be no older than v1.1.0 to support `cloud` block

  cloud {
    organization = "systema-solaris"
  workspaces {
    name = "awesome-azure-powershell"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     =  var.resource_group_name 
  location = "uksouth"


  tags = {
  Environment = "Bella Terra"
    Team = "DevOps"
  }
}

/*
# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "Solar-Network"
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  resource_group_name = azurerm_resource_group.rg.name
} */
