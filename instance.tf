resource "aws_instance" "production-server" {
  ami = "ami-02eb7a4783e7e9317" # replace with desired AMI ID
  instance_type = "t2.medium"
  availability_zone = "ap-south-1a" # specify a zone in ap-south-1 region
  vpc_security_group_ids = [aws_security_group.sg-0888c23f07272012c.id]
  subnet_id = "<YOUR SUBNET ID>"
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
