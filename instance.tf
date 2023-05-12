resource "aws_security_group" "ec2group123" {
  name        = "ec2group123"
  description = "Security group for EC2 instances"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "insur-proj" {
  ami               = "ami-02eb7a4783e7e9317"
  instance_type     = "t2.medium"
  availability_zone = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.ec2group123.id]
  key_name          = "pu-ub"
  tags = {
    name = "ansible_instance"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/ubuntu/star-agile-banking-finance-project-babu/test-server/bank-pro.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
       "chmod 400 /home/ubuntu/star-agile-banking-finance-project-babu/test-server/bank-pro.pem",
      "ansible-playbook /home/ubuntu/star-agile-banking-finance-project-babu/test-server/finance-playbook.yml"
    ]
  }
}

