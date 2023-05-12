resource "aws_instance" "production-server" {
  ami = "ami-0123456789abcdef0" # replace with desired AMI ID
  instance_type = "t2.medium"
  availability_zone = "ap-south-1a" # specify a zone in ap-south-1 region
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
