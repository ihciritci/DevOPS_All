terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  backend "s3" {
    bucket = "talrise-remote-state-s3"
    region = "us-east-1"
    dynamodb_table = "talrise-remote-state-dynamodb"
    encrypt = true
  }

}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_instance" "tf-ec2" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  key_name  = "${var.key_name}"
  vpc_security_group_ids = [aws_security_group.server-sg.id]
  tags = {
    Name = "${var.ec2_name}-instance"
  }
  user_data              = filebase64("user-data.sh")
}


variable "ec2_name" {
  default = "env-dev-talrise"
}

variable "key_name"  {
  default ="talrise.pem"
}
