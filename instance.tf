resource "aws_security_group" "ec2group123" {
  name_prefix = "ec2group123-"
  vpc_id      = "vpc-06c5a53d1e3aa7669"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "production-server" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.medium"
  availability_zone = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.ec2group123.id]
  key_name = "pu-ub.ppk"
  tags = {
    name = "ansible_instance"
  }
  provisioner "remote-exec" {
    inline = [
      "ansible-playbook bankdeployplaybook.yml"
    ]
  }
}
