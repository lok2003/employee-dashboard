resource "azurerm_container_registry" "frontend_acr" {
  name                = var.acr.frontend_name 
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = var.acr.sku
  admin_enabled       = var.acr.admin_enabled
  georeplications {
    location                        = "East US"
    global_endpoint_routing_enabled = true
    zone_redundancy_enabled         = true
    tags                            = {}
  }
}


resource "azurerm_container_registry" "backend_acr" {
  name                = var.acr.backend_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  sku                 = var.acr.sku
  admin_enabled       = var.acr.admin_enabled
  georeplications {
    location                        = "East US"
    global_endpoint_routing_enabled = true
    zone_redundancy_enabled         = true
    tags                            = {}
  }
}
