module "vnet" {
  source         = "./modules/vnet"
  resource_group = var.resource_group
  azvnet         = var.azvnet
  subnetaks      = var.subnetaks
  depends_on     = [azurerm_resource_group.aks_resources]
}

module "nsg" {
  source         = "./modules/nsg"
  resource_group = var.resource_group
  nsg            = var.nsg
  rule           = var.rule
  subnet_id      = module.vnet.subnet_ids[1]
  depends_on     = [module.vnet]
}

module "cluster" {
  source         = "./modules/AKS"
  resource_group = var.resource_group
  aks            = var.aks
  subnet_id      = module.vnet.subnet_ids[1]
  # log_analytics_workspace_id = "/subscriptions/04cbb0f1-f3ee-4e22-bad8-a49dae98e05e/resourceGroups/my-aks/providers/Microsoft.OperationalInsights/workspaces/aks-monitoring-workspace"
  # azure_monitor_workspace_id = "/subscriptions/04cbb0f1-f3ee-4e22-bad8-a49dae98e05e/resourceGroups/my-aks/providers/Microsoft.Monitor/accounts/aks-metrics-workspace"
  depends_on = [azurerm_resource_group.aks_resources, module.vnet, module.nsg]
}


module "acr" {
  source         = "./modules/acr"
  acr            = var.acr
  resource_group = var.resource_group
}
