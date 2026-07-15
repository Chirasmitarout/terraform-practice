variable "region" {
  type = string
}

variable "db_identifier" {
  type = string
}

variable "database_name" {
  type = string
}

variable "master_username" {
  type = string
}

variable "master_password" {
  type      = string
  sensitive = true
}

variable "allocated_storage" {
  type = number
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "db_subnet_group_name" {
  type = string
}

variable "allowed_cidr_blocks" {
  type = list(string)
}