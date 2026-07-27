 module "server" {
  source = "./ec2"
  ami = var.ami
  instance_type = var.instance_type
  tags = var.tags   
  }

  module "vpc" {
  source = "./vpc"

  vpc_cidr      = var.vpc_cidr
  subnet1_cidr  = var.subnet1_cidr
  subnet2_cidr  = var.subnet2_cidr
}