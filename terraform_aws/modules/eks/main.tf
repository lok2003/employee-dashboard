resource "aws_eks_cluster" "eks_cluster" {
  name = var.eks_cluster.name
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
  role_arn = var.role_arn
  version  = var.eks_cluster.version
  vpc_config {
    subnet_ids = var.subnet_ids
  }
  #depends_on = [ modules/eks_node_role ]
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  tags = {
    Environment = var.eks_cluster.tags
  }
}