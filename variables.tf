variable "aws_region" {
  type        = string
  description = "AWS region for all resources"
}

variable "environment" {
  type        = string
  description = "Environment name used for prefixing and tagging resources"
}

variable "key_name" {
  type        = string
  description = "The name of the pre-created AWS SSH Key Pair"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for Public Subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for Private Subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones to distribute subnets"
}