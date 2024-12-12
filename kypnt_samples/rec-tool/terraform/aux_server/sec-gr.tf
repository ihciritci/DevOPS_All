resource "aws_security_group" "server-sg" {
  name   = "AuxserverSecurityGroup"
  vpc_id = data.aws_vpc.default.id
  tags = {
    "Name" = "AuxserverSecurityGroup"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }
   ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8081
    protocol    = "tcp"
    to_port     = 8081
  }
    ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 9000
    protocol    = "tcp"
    to_port     = 9000
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}