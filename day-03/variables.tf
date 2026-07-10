variable "aws_region" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "az" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "allowed_ip" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_name" {
  type = string
}