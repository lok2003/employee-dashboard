
output "aks_cluster_node" {
  value = azurerm_kubernetes_cluster.cluster.node_resource_group
}



output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.cluster.name
}

output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.cluster.id
}