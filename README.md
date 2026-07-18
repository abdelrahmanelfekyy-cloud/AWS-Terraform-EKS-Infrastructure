# AWS EKS & Networking Infrastructure via Terraform

This repository contains a modularized Terraform configuration to provision a production-ready **Amazon EKS (Elastic Kubernetes Service)** cluster inside a custom, secure **VPC (Virtual Private Cloud)** on AWS.

## Architecture Overview

The infrastructure deployed by this codebase includes:
* **Networking Module:** A custom VPC with Public Subnets (for Internet Gateways/Load Balancers) and Private Subnets (isolated zones for secure application hosting).
* **EKS Module:** A managed Kubernetes Control Plane integrated with automated EC2 Worker Nodes running securely within the private subnets.

---

## Repository Structure

```text
.
├── main.tf                 # Root configuration calling network and EKS modules
├── variables.tf            # Global input variables
├── terraform.tfvars
├── outputs.tf              # Global outputs (Cluster endpoint, VPC ID, etc.)
├── providers.tf            # AWS and Terraform provider settings
└── modules/
    ├── networking/         # Custom VPC, Subnets, and Route Tables
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── eks/                # EKS Cluster, Node Groups, and IAM Roles
    |    ├── main.tf
    |    ├── variables.tf
    |    └── outputs.tf
    |___ ec2/
    |    ├── main.tf
    |    ├── variables.tf
    |    └── outputs.t
    |___ security-group/
    |    ├── main.tf
    |    ├── variables.tf
    |    └── outputs.t