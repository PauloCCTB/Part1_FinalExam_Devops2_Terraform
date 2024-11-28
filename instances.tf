resource "aws_instance" "web1" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "ProductionEnv1"
  }
}

resource "aws_instance" "web2" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "ProductionEnv2"
  }
}

resource "aws_instance" "jenkins" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  user_data       = file("scripts/jenkins_install.sh")
  tags = {
    Name = "JenkinsController"
  }
}

resource "aws_instance" "testing" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_b.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "TestingEnv"
  }
}

resource "aws_instance" "staging" {
  ami             = "ami-0440d3b780d96b29d"
  instance_type   = "t2.micro"
  subnet_id     = aws_subnet.main_a.id
  security_groups = [aws_security_group.web_sg.id]
  key_name        = var.key_name
  tags = {
    Name = "StagingEnv"
  }
}