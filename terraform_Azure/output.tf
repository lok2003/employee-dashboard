output "vnet" {
  value = module.vnet
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}


output "nsg" {
  value = module.nsg
}

output "nsg_id" {
  value = module.nsg.nsg_id
}


output "aks_cluster" {
  value = module.cluster
}

output "aks_cluster_credentials" {
  value = "az aks get-credentials --resource-group ${var.resource_group.name} --name ${module.cluster.aks_cluster_name} "
}


# output "log_analytics_workspace_id" {
#   value = module.cluster.log_analytics_workspace_id
# }

# output "azure_monitor_workspace_id" {
#   value = module.cluster.azure_monitor_workspace_id
# }

output "frontend_acr_name" {
  value = module.acr.frontend_acr_name
}

output "frontend_acr_id" {
  value = module.acr.frontend_acr_id
}

output "frontend_acr_login_server" {
  value = module.acr.frontend_acr_login_server
}

output "backend_acr_name" {
  value = module.acr.frontend_acr_name
}

output "backend_acr_id" {
  value = module.acr.backend_acr_id
}

output "backend_acr_login_server" {
  value = module.acr.backend_acr_login_server
}