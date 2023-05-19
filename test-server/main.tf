resource "aws_instance" "test-server" {
  ami                = "ami-02eb7a4783e7e9317"
  instance_type      = "t2.micro"
  availability_zone  = "ap-south-1b"
  vpc_security_group_ids = ["sg-0dcfb1d7312730a94"]  # Replace with your existing security group ID
  key_name           = "pu-ub"

  tags = {
    name = "test-server"
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-playbook bankdeployplaybook.yml"
    ]
  }
}


