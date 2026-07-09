variable "region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
}

variable "subnet_cidr" {
  description = "Subnet CIDR Block"
  type        = string
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "ami_id" {
  description = "AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
}

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket Name"
  type        = string
}