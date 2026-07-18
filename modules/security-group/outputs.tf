output "cluster_sg_id" {
  value       = aws_security_group.eks_cluster.id
  description = "The ID of the EKS Cluster Security Group"
}

output "nodes_sg_id" {
  value       = aws_security_group.eks_nodes.id
  description = "The ID of the EKS Nodes Security Group"
}