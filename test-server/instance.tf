resource "aws_instance" "ins-deploy-ansible-champ" {
  ami                    = "ami-02eb7a4783e7e9317"
  instance_type          = "t2.micro"
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = ["sg-0888c23f07272012c"]
  key_name               = "sample"

  tags = {
    Name = "ansible_instance"
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook bankdeployplaybook.yml"
    ]
  }
}

