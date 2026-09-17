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
  depends_on     = [azurerm_resource_group.aks_resources, module.vnet, module.nsg]
}
