resource "aws_instance" "ins-deploy-ansible" {
  ami                    = "ami-02eb7a4783e7e9317"
  instance_type          = "t2.micro"
  key_name               = "sample" 
  vpc_security_group_ids = ["sg-0888c23f07272012c"]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./sample.pem") 
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["echo 'Waiting for instance to start...'"]
  }

  tags = {
    Name = "ansible_instance"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.ansible_instance.public_ip} > inventory"
  }

  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/bank-pro/test-server/finance-playbook.yml"
  }
}

