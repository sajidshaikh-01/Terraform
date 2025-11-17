output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_kubeconfig" {
  value = module.eks.kubeconfig_filename
}

output "node_group_role_arn" {
  value = module.eks.eks_managed_node_groups[0].iam_role_arn
}
