provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3TGRI6WEC65Y4YXB"
  secret_key = "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"
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
}

# Create an AWS EC2 instance
resource "aws_instance" {
  ami           = "ami-02eb7a4783e7e9317"
  key_name      = "exampl"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.myFirstSecurityGroup.id]

  tags = {
    Name = "terra"
  }
}

# Allocate an Elastic IP address
resource "aws_eip" "myFirstEip" {
  vpc  = true
  tags = {
    Name = "my-elastic-ip"
  }
}


