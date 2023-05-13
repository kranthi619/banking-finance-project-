resource "aws_instance" "production-server" {
 ami = ""
 instance_type = "t2.micro"
 availability_zone = "ap-south-1a"
 VPC_security_groups = ["ami-02eb7a4783e7e9317"]
 key_name = "sample"
 tags = {
 name = "ansible_instance"
 }
 provisioner "remote-exec" {
 inline = [
     "ansible-playbook bankdeployplaybook.yml"
     ]
     }
     }
