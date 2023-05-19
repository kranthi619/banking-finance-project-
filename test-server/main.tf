
resource "aws_instance" "test-server" {
  ami                = "ami-02eb7a4783e7e9317"
  instance_type      = "t2.micro"
  key_name           = "exampl"
  vpc_security_group_ids = ["sg-0dcfb1d7312730a94"]
  tags = {
    Name = "test-server"
  }
  
  provisioner "remote-exec" {
    command = "sleep 60 && 'Instance ready'"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./exampl.pem")
    host        = self.public_ip
  }
  
  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/pro-bank2/test-server/bankdeployplaybook.yml"
  }
}

