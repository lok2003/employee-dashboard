resource "azurerm_virtual_network" "aks_vnet" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  name                = var.azvnet.name
  address_space       = [var.azvnet.address_space]
}

resource "azurerm_subnet" "aks_subnet" {
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  count                = length(var.subnetaks)
  name                 = var.subnetaks[count.index].name
  address_prefixes     = [var.subnetaks[count.index].address_prefixes]
}
