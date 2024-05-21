# Resource Group
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${random_pet.prefix.id}-rg"
}

# Virtual Network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "${random_pet.prefix.id}-vnet"
  address_space       = ["20.20.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet 1
resource "azurerm_subnet" "my_terraform_subnet_1" {
  name                 = "subnet-1"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["20.20.0.0/24"]
}

# Subnet 2
resource "azurerm_subnet" "my_terraform_subnet_2" {
  name                 = "subnet-2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["20.20.1.0/24"]
}

resource "random_pet" "prefix" {
  prefix = var.resource_group_name_prefix
  length = 1
}

resource "azurerm_storage_account" "StgAcc" {
  name                     = var.StgAccName
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}