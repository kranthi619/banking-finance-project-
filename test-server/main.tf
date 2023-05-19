resource "aws_security_group" "ec2group123" {
  name        = "ec2group123"
  description = "EC2 Security Group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add any additional ingress or egress rules as needed
}

resource "aws_instance" "production-server" {
  ami                = "ami-02eb7a4783e7e9317"
  instance_type      = "t2.micro"
  availability_zone  = "ap-south-1b"
  vpc_security_group_ids = [aws_security_group.ec2group123.id]
  key_name           = "pu-ub"

  tags = {
    name = "ansible_instance"
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook bankdeployplaybook.yml"
    ]
  }
}
