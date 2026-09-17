terraform {
  required_version = ">=1.5.0"
  required_providers {
    azurerm = {
      version = "=5.0.0"
      source  = "hashicorp/azurerm"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_resources" {
  name     = var.resource_group.name
  location = var.resource_group.location
}