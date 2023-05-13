provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3TGRI6WEPQWGGO7X"
  secret_key = "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"
}

resource "aws_instance" "server" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  subnet_id = "subnet-0903fa3bf38afc6da"
  security_groups = ["sg-0888c23f07272012c"]
  key_name = aws_key_pair.deployer.key_name

tags = {
  Name = "terraform-server"
 }
}

resource "aws_key_pair" "deployer" {
  key_name   = "sample"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDfjstD25HHM1dS6nmnyEaGwmgdynkyOq79qZptvYmTZj4E8O+ZDb/PW5lweWPKJyNdNB4Z+NBQxV/A5FDFS+PefusAtixD2JEve9ZT3SUtGzWT8xMNUEzCnn4luvW4DdV9hWX1EtWh4o5WUQkvi1YZyecv2uz/68K/teewI53WKlgd0Vz5jnQY6sg+oedku7olRAtwGVI+B+ferKVST9tMB7qNQY58GAlcSPmia9pzBnsi2Krbh1D88W6m7JpDEVQ//0iwz6Ah0lQGrLFngyma3BaGmHKL3Efit0gPXUriIHxfcNiAkB3fk51MAKy9WMsPJWyrSG3QP+YeL3Zw0HOw7q/Xuq1S3AzZLFsl1vliXdoIp3zC61R3UjC9Kd/BpZubX5NYR2Y9E+TTqzQUDjt+t+DevH/09rR285X40SsW2R/FBobSavhyct2RYerYbhfQa1teNiv0Y2bGu44p2j7Km2WbEwQGekO67WoMaVddVhepeiulzuMjjR39JX30pRs= realme@kranthi"
}
