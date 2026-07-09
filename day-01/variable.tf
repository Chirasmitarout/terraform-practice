variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = ""
}

variable "subnet_cidr" {
  description = "CIDR block for Subnet"
  type        = string
  default     = ""
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = ""
}