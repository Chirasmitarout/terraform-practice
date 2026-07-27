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
    variable "vpc_cidr" {}
variable "subnet1_cidr" {}
variable "subnet2_cidr" {}