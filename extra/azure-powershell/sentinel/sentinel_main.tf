provider "azurerm" {
    features {}
  }

  terraform {
    required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.96.0"
      }
    }
  }

  resource "azurerm_subscription_policy_assignment" "shine_light" {
  name                  = "audit-vm-manageddisks"
  subscription_id       = var.custom_scope
  policy_definition_id  = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
  description           = "Shows all virtual machines not using managed disks"
  display_name          = "Audit VMs without managed disks assignment"
  }