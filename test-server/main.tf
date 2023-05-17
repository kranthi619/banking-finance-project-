provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "test-server-sg" {
  name_prefix = "test-server-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "exampl"
  vpc_security_group_ids = [aws_security_group.test-server-sg.id]


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("exampl.pem")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'wait to start instance'",
    ]
  }

  tags = {
    Name = "test-server"
  }

  provisioner "local-exec" {
    command = "echo '${aws_instance.test-server.public_ip}' > inventory"
  }
}






