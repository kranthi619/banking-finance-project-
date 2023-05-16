provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "exampl"
  vpc_security_group_ids = ["sg-0888c23f07272012c"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("/test-server/exampl.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'wait to start instance'",
    ]
  }

  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /root/star-agile-banking-finance-project-babu/test-server/finance-playbook.yml"
  }
}




