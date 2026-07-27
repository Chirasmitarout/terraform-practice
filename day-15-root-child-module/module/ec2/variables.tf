variable "ami" {
  type = string
  default = ""

}

variable "instance_type" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {}
}