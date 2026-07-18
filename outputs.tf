output "bastion_host_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}