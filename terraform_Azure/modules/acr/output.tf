output "frontend_acr_name" {
  value = azurerm_container_registry.frontend_acr.name 
}

output "frontend_acr_id" {
  value = azurerm_container_registry.frontend_acr.id
}

output "frontend_acr_login_server" {
  value = azurerm_container_registry.frontend_acr.login_server
}


output "backend_acr_name" {
  value = azurerm_container_registry.backend_acr.name 
}

output "backend_acr_id" {
  value = azurerm_container_registry.backend_acr.id
}

output "backend_acr_login_server" {
  value = azurerm_container_registry.backend_acr.login_server
}