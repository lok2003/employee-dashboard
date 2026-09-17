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