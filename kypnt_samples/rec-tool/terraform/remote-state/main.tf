locals {
  aws_region = "us-east-1"
  prefix     = "talrise-remote-state"
  ssm_prefix = "/org/eks-talrise/terraform"
  common_tags = {
    Project   = "eks-talrise"
    ManagedBy = "Terraform"
  }
}