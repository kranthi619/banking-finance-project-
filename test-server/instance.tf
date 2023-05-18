resource "aws_instance" "production-server" {
 ami = "ami-02eb7a4783e7e9317"
 instance_type = "t2.micro"
 availability_zone = "ap-south-1b"
 VPC_security_groups = [aws_security_group.ec2group123.id]
 key_name = "pu-ub"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook bankdeployplaybook.yml"
     ]
     }
     }
