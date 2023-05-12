resource "aws_instance" "insur-proj" {
  ami = "ami-02eb7a4783e7e9317"
  instance_type = "t2.medium"
  availability_zone = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.ec2group123.id]
  key_name = "pu-ub"
  tags = {
    name = "ansible_instance"
  }
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("~/.ssh/pu-up.ppk")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "ansible-playbook bankdeployplaybook.yml"
    ]
  }
}

