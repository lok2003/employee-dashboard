output "vpc" {
  value = module.vpc
}

output "public_subnet" {
  value = module.vpc.public_subnet_ids
}
output "private_subnet" {
  value = module.vpc.private_subnet_ids
}

output "sg" {
  value = module.sg
}

output "eks-cluster" {
  value = module.cluster
}

output "node-group" {
  value = module.node-role
}

output "frontend_arn" {
  value = module.ecr.frontend_arn
}

output "frontend_ecr_repository_url" {
  value = module.ecr.frontend_ecr_repository_url
}

output "backend_arn" {
  value = module.ecr.backend_arn
}

output "backend_ecr_repository_url" {
  value = module.ecr.backend_ecr_repository_url
}

output "eks_log_group_name" {
  value = module.monitoring.log_group_name
}
output "eks_log_group_arn" {
  value = module.monitoring.log_group_arn
}