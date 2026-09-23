module "vpc" {
  source         = "./modules/vpc"
  vpc            = var.vpc
  public_subnet  = var.public_subnet
  private_subnet = var.private_subnet
}

module "sg" {
  source  = "./modules/sg"
  aws_sg  = var.aws_sg
  vpc_id  = module.vpc.vpc
  ingress = var.ingress
}


module "eks-cluster-role" {
  source = "./modules/eks-cluster-role"
}

module "node-role" {
  source = "./modules/node"
}

module "cluster" {
  source      = "./modules/eks"
  eks_cluster = var.eks_cluster
  role_arn    = module.eks-cluster-role.eks_cluster_role_arn
  subnet_ids  = module.vpc.private_subnet_ids
}

module "node-group" {
  source     = "./modules/worker-node"
  node       = var.node
  cluster    = module.cluster.eks_cluster
  role_arn   = module.node-role.eks_node_iam_role
  subnet_ids = module.vpc.private_subnet_ids
}

module "addons" {
  source       = "./modules/addons"
  cluster_name = module.cluster.eks_cluster
}

module "ecr" {
  source = "./modules/ecr"
  ecr    = var.ecr
}

module "monitoring" {
  source        = "./modules/monitoring"
  log_retention = var.log_retention
  eks_cluster   = module.cluster.eks_cluster
  alerts_email  = var.alerts_email
}
