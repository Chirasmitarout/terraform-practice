resource "aws_instance" "name" {
  ami           = "ami-0b826bb6d96d2afe4"
  instance_type = "t2.micro"

  user_data = <<-EOF
#!/bin/bash
dnf update -y
dnf install -y nginx git
systemctl enable nginx
systemctl start nginx
EOF

  tags = {
    Name = "chiru-git2"
  }
}