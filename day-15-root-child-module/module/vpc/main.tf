resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "My-VPC"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet1_cidr

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet2_cidr

  tags = {
    Name = "Subnet-2"
  }
}