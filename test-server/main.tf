resource "aws_instance" "production-server" {
  ami                = "ami-02eb7a4783e7e9317"
  instance_type      = "t2.micro"
  availability_zone  = "ap-south-1b"
  vpc_security_group_ids = [aws_security_group.sg-0f10d4bcd49b6d516]
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

