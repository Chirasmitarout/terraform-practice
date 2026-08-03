# ==============================
# VPC
# ==============================

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Main-VPC"
  }
}

# ==============================
# Internet Gateway
# ==============================

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main-IGW"
  }
}

# ==============================
# Public Subnet 1
# ==============================

resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet1
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-1"
  }
}

# ==============================
# Public Subnet 2
# ==============================

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet2
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-2"
  }
}

# ==============================
# Private Subnet 1
# ==============================

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet1
  availability_zone = var.az1

  tags = {
    Name = "Private-Subnet-1"
  }
}

# ==============================
# Private Subnet 2
# ==============================

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet2
  availability_zone = var.az2

  tags = {
    Name = "Private-Subnet-2"
  }
}

# ==============================
# Public Route Table
# ==============================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

# ==============================
# Route Table Association
# ==============================

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# ==============================
# Web Security Group
# ==============================

resource "aws_security_group" "web" {
  name        = "Web-SG"
  description = "Allow HTTP SSH HTTPS"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-SG"
  }
}

# ==============================
# Database Security Group
# ==============================

resource "aws_security_group" "db" {
  name        = "DB-SG"
  description = "Allow MySQL from Web SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DB-SG"
  }
}