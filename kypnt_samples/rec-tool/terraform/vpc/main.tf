locals {
  prefix        = "eks-talrise"
  vpc_name      = "${local.prefix}-vpc"
  vpc_cidr      = var.vpc_cidr
  common_tags   = {
    Environment = "dev"
    Project     = "eks-talrise"
  }
}