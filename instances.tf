resource "aws_instance" "web1" {
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/Setup.sh")
  tags = {
    Name = "Production1"
  }
}

resource "aws_instance" "web2" {
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/Setup.sh")                                                                                            
  tags = {
    Name = "Production2"
  }
}

resource "aws_instance" "jenkins" {
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.medium"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/jenkins_install.sh")
  provisioner "remote-exec" {
        inline = [
                "echo '${tls_private_key.example.private_key_pem}' > /home/ec2-user/instance_key",
                "chmod 777 /home/ec2-user/instance_key",
                "echo 'jenkins ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers > /dev/null"

        ]
        connection {
                type = "ssh"
                user = "ec2-user"
                private_key = tls_private_key.example.private_key_pem
                host = aws_instance.jenkins.public_ip
        } 
  }

  root_block_device {
     volume_size = 20      # Size in GiB
     volume_type = "gp3"   # General Purpose SSD 
  }

  tags = {
    Name = "JenkinsController"
  }
}

resource "aws_instance" "testing" {
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/Setup.sh")                                                                                                                                               
  tags = {
    Name = "Testing"
  }
}

resource "aws_instance" "staging" {
  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/Setup.sh")                                                                                                                                               
  tags = {
    Name = "Staging"
  }
}
