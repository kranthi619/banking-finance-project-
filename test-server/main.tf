provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "my-server" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.medium"
  vpc_security_group_ids = ["sg-0b6d460909f544b8b"]

  tags = {
    Name = "my-server"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("pu-ub.ppk")
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.my-server.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/banking-proj/test-server/finance-playbook.yml"
  }
}
