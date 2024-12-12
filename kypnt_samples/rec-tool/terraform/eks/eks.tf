locals {
  cluster_name    = "${local.prefix}-cluster"
  aws_account_id  = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

# EKS Terraform - Cluster
resource "aws_eks_cluster" "eks_cluster" {
  depends_on = [aws_iam_role_policy_attachment.eks_iam_policy_attachment]

  name     = local.cluster_name
  role_arn = aws_iam_role.eks_iam_role.arn

  vpc_config {
    subnet_ids = concat(local.public_subnets, local.private_subnets)
  }

  tags = merge(
    {
      Name = local.cluster_name
    },
    local.common_tags
  )
}
          
# EKS Terraform - Creating the private EKS Node Group
resource "aws_eks_node_group" "private_node_group_backend" {
  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy_attachment,
    aws_iam_role_policy_attachment.cni_policy_attachment,
    aws_iam_role_policy_attachment.ec2_readonly_policy_attachment,
  ]

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.cluster_name}-backend-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids      = local.private_subnets
  
  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]
  disk_size      = 8

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  tags = {
    "node_group_tags"= "worker-nodes"
    "node_tags" = "backend-worker"  
  }
}

resource "aws_eks_node_group" "private_node_group_db" {
  depends_on = [
    aws_iam_role_policy_attachment.worker_node_policy_attachment,
    aws_iam_role_policy_attachment.cni_policy_attachment,
    aws_iam_role_policy_attachment.ec2_readonly_policy_attachment,
  ]

  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${local.cluster_name}-db-ng"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids      = local.private_subnets

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]
  disk_size      = 8

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }  
  tags = {
    "node_group_tags"= "worker-nodes"
    "node_tags" = "db-worker"  
  }
}

data "template_file" "config" {
  template = file("${path.module}/templates/config.tpl")
  vars = {
    certificate_data  = aws_eks_cluster.eks_cluster.certificate_authority[0].data
    cluster_endpoint  = aws_eks_cluster.eks_cluster.endpoint
    aws_region        = var.aws_region
    cluster_name      = local.cluster_name
    account_id        = local.aws_account_id
  }
}

resource "local_file" "config" {
  content  = data.template_file.config.rendered
  filename = "${path.module}/${local.cluster_name}_config"
}
