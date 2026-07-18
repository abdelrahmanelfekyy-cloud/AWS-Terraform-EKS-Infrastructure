module "networking" {
  source               = "./modules/networking"
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "security_group" {
  source      = "./modules/security-group"
  environment = var.environment
  vpc_id      = module.networking.vpc_id
}

module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
  cluster_sg_id      = module.security_group.cluster_sg_id
  nodes_sg_id        = module.security_group.nodes_sg_id
  key_name           = var.key_name
}

module "ec2" {
  source            = "./modules/ec2"
  environment       = var.environment
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  key_name          = var.key_name
  nodes_sg_id       = module.security_group.nodes_sg_id
}