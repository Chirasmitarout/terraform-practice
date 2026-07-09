# VPC
resource "aws_vpc" "chiru_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Subnet
resource "aws_subnet" "chiru_subnet" {
  vpc_id                  = aws_vpc.chiru_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "chiru_igw" {
  vpc_id = aws_vpc.chiru_vpc.id

  tags = {
    Name = "chiru-igw"
  }
}

# Route Table
resource "aws_route_table" "chiru_rt" {
  vpc_id = aws_vpc.chiru_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.chiru_igw.id
  }

  tags = {
    Name = "chiru-route-table"
  }
}

# Route Table Association
resource "aws_route_table_association" "chiru_rta" {
  subnet_id      = aws_subnet.chiru_subnet.id
  route_table_id = aws_route_table.chiru_rt.id
}

# Security Group
resource "aws_security_group" "chiru_sg" {
  name   = "chiru-security-group"
  vpc_id = aws_vpc.chiru_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

# EC2 Instance
resource "aws_instance" "chiru_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.chiru_subnet.id
  vpc_security_group_ids      = [aws_security_group.chiru_sg.id]
  associate_public_ip_address = true

  tags = {
    Name = var.instance_name
  }
}

# S3 Bucket
resource "aws_s3_bucket""chiru_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}