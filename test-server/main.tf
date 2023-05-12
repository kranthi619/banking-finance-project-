provider "aws" {
  region = "ap-south-1" # Change to the region of your choice
}

resource "aws_instance" "example" {
  ami           = "ami-02eb7a4783e7e9317" # Ubuntu 18.04 LTS 64-bit
  instance_type = "t2.micro" # Change to the instance type of your choice
  key_name      = "pu-ub" # Change to the name of your key pair in AWS
  vpc_security_group_ids = [aws_security_group.example.id]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/C:/Users/Realme/Downloads/pu-ub.pem") # Change to the path of your private key file
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/banking-proj/test-server/finance-playbook.yml"
  }

  tags = {
    Name = "project-inst"
  }
}

resource "aws_security_group" "example" {
  name_prefix = "example-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open SSH port to the world
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open HTTP port to the world
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

