terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "26a037c9-baf8-4ed0-b3ed-bb41dc6a3ddb"
}

resource "azurerm_resource_group" "rahul" {
  name     = "rahul-rg"
  location = "West US"
}

resource "azurerm_storage_account" "rahulstg" {
  name                     = "monkeysdf"
  resource_group_name      = azurerm_resource_group.rahul.name
  location                 = azurerm_resource_group.rahul.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}



resource "azurerm_storage_container" "rahulstgcontainer" {
  name                  = "test"
  storage_account_name  = azurerm_storage_account.rahulstg.name
  container_access_type = "private"
}


terraform {
  backend "azurerm" {
    resource_group_name  = "rahul-rg"
    storage_account_name = "monkeysdf"
    container_name       = "test"
    key                  = "terraform.tfstate"
  }
}


