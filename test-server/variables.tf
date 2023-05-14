variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "ap-south-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "sample"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     =  "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "launch-wizard-62"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "my-terraform-instace"
}

variable "ami_id" {
  description = "AMI for Amazon Ami2 Ec2 instance"
  default     = "ami-02eb7a4783e7e9317"
}
