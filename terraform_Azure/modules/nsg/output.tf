output "nsg" {
  value = azurerm_network_security_group.aks_nsg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.aks_nsg.id
}