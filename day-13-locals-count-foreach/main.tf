############################
# VPC
############################
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "My-VPC"
  }
}

############################
# Internet Gateway
############################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "My-IGW"
  }
}

############################
# Public Subnets
############################
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet-3"
  }
}

############################
# Route Table
############################
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

############################
# Locals
############################
locals {
  subnet_ids = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id,
    aws_subnet.subnet3.id
  ]
}

############################
# Route Table Association
############################
resource "aws_route_table_association" "public" {
  for_each = {
    subnet1 = aws_subnet.subnet1.id
    subnet2 = aws_subnet.subnet2.id
    subnet3 = aws_subnet.subnet3.id
  }

  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}