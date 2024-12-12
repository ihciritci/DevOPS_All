# EKS Terraform - IAM Role for K8s Cluster (Control Plane)

resource "aws_iam_role" "eks_iam_role" {
  name = "eks-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })

  tags = {
    "Terraform" = "true"
  }
}

resource "aws_iam_role_policy_attachment" "eks_iam_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_iam_role.name
}