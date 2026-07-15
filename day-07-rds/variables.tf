variable "region" {}

variable "vpc_cidr" {}
variable "az1" {
  description = "Availability Zone for Public Subnet 1"
  type        = string
}

variable "az2" {
  description = "Availability Zone for Public Subnet 2"
  type        = string
}

variable "public_subnet1" {}

variable "public_subnet2" {}

variable "db_identifier" {}

variable "database_name" {}

variable "db_username" {}

variable "db_password" {}

variable "read_replica_identifier" {
  description = "Identifier for the read replica"
  type        = string
}