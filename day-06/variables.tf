variable "aws_region" {}

variable "vpc_name" {}

variable "vpc_cidr" {}

variable "public_subnet_cidr" {}

variable "private_subnet_cidr" {}

variable "az" {}

variable "ami" {}

variable "instance_type" {}

variable "private_subnet2_cidr" {}

variable "az2" {}

variable "db_username" {}

variable "db_password" {
  sensitive = true
}

