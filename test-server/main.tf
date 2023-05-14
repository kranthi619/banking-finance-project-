# Configure the AWS provider
provider "aws" {
  region = "ap-south-1"
}

# Create a security group
resource "aws_security_group" "myFirstSecurityGroup" {
  name_prefix = "my-first-security-group-"
  description = "security group for EC2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group
  }
}

# Create an AWS EC2 instance
resource "aws_instance" "myFirstInstance" {
  ami           = var.ami_id
  key_name      = var.key_name
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.myFirstSecurityGroup.id]

  tags = {
    Name = var.tag_name
  }
}

# Allocate an Elastic IP address
resource "aws_eip" "myFirstEip" {
  vpc  = true
  tags = {
    Name = "my-elastic-ip"
  }
}

