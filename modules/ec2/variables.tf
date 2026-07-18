variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of Public Subnet IDs to deploy the EC2"
}

variable "key_name" {
  type        = string
  description = "The name of the SSH Key Pair (key3)"
}

variable "nodes_sg_id" {
  type        = string
  description = "The ID of the EKS Nodes Security Group to allow connection"
}