resource "azurerm_kubernetes_cluster" "cluster" {
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  name                = var.aks.name
  dns_prefix          = var.aks.dns_prefix
  default_node_pool {
    name           = var.aks.node_pool_name
    node_count     = var.aks.node_count
    vm_size        = var.aks.vm_size
    vnet_subnet_id = var.subnet_id
  }
  identity {
    type = "SystemAssigned"
  }
  node_provisioning_profile {
    mode = "Manual"
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    service_cidr      = var.aks.service_cidr
    dns_service_ip    = var.aks.dns_service_ip
  }
}
