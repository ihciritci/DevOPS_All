# we’re using Terraform S3 backend for storing state files and DynamoDB for Terraform execution locks.

terraform {
  backend "s3" {
    bucket  = "talrise-remote-state-s3"
    key     = "eks-talrise-vpc.tfstate"    # Terraform statefile name
    region  = "us-east-1"
    encrypt = "true"
    dynamodb_table = "talrise-remote-state-dynamodb"
  }
}