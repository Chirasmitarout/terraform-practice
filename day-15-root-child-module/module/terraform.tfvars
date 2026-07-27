ami = "ami-004f790b835b26145"
instance_type = "t2.micro"
tags = {
  Name = "MyEC2Instance"
}
vpc_cidr     = "10.0.0.0/16"
subnet1_cidr = "10.0.1.0/24"
subnet2_cidr = "10.0.2.0/24"