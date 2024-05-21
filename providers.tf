terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

# to create the terraform state file in the provided storage account
    backend "azurerm" {
    resource_group_name  = "MKSRG10"
    storage_account_name = "mksterrastore10"
    container_name       = "terracontr10"
    key                  = "actions.tfstate"
  }
}

# in case having multiple subscriptions, specify the subscription for terraform execution
provider "azurerm" {
  features {}
   tenant_id = "b6292880-50d5-49f9-9cc5-f7f588dcbacb"
   subscription_id = "7c2b0309-c995-4d44-ad88-0db9e6ba490b"
}
