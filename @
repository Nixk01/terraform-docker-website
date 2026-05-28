data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_security_group" "web_sg" {
  name = "website-security-group"

  ingress {
    description = "HTTP Access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "website_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data_replace_on_change = true

  user_data = <<-EOF
#!/bin/bash

exec > /var/log/user-data.log 2>&1

apt-get update -y

sleep 15

apt-get install -y docker.io

systemctl start docker
systemctl enable docker

docker --version

docker pull nginx

mkdir -p /home/ubuntu/website

cat <<HTML > /home/ubuntu/website/index.html
<html>
<head>
  <title>Nixk DevOps Lab</title>
</head>

<body style="background:black;color:lime;text-align:center;padding-top:100px;">
  <h1>🚀 Nixk DevOps Lab</h1>
  <h2>Terraform + Docker + nginx</h2>
</body>
</html>
HTML

docker run -d \
  --name nginx-server \
  -p 8080:80 \
  -v /home/ubuntu/website:/usr/share/nginx/html \
  nginx
EOF

  tags = {
    Name = "Terraform-Docker-Website"
  }
}
