resource "aws_instance" "ins-deploy-ansible" {
  ami                    = "ami-02eb7a4783e7e9317"
  instance_type          = "t2.micro"
  key_name               = "champ-pk" 
  vpc_security_group_ids = ["sg-0888c23f07272012c"]

  provisioner "remote-exec" {
    inline = ["echo 'Waiting for instance to start...'"]
  }

  tags = {
    Name = "ansible_instance"
  }
}

resource "null_resource" "ansible_inventory" {
  depends_on = [
    aws_instance.ins-deploy-ansible
  ]

  provisioner "local-exec" {
    command = "echo ${aws_instance.ins-deploy-ansible.public_ip} > inventory && ansible-playbook /var/lib/jenkins/workspace/bank-pro/test-server/finance-playbook.yml"
  }
}

