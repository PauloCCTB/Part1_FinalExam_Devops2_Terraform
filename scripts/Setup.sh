#!/bin/bash
sudo yum -y update
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.corretto.aws/corretto.repo
sudo yum update -y
sudo yum -y install java-17-amazon-corretto
curl -fsSL https://rpm.nodesource.com/setup_21.x | sudo bash -
sudo dnf install -y nodejs
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
sudo chown ec2-user:ec2-user /var/www/html
sudo systemctl restart httpd
sudo dnf install -y xorg-x11-server-Xvfb alsa-lib
sudo dnf install -y libXtst libX11 libXcomposite libXdamage
sudo dnf install -y mesa-libGL
sudo dnf install -y atk
sudo dnf install -y gtk3
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y google-chrome-stable_current_x86_64.rpm
sudo yum -y install git
