resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr
  tags = {
    Name=var.vpc_name
  }
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr
    tags = {
      Name=var.subnet_name
    }
  
}