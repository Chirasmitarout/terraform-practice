aws_region = "us-east-1"

vpc_cidr = "10.0.0.0/16"
vpc_name = "chiru-vpc"

subnet_cidr = "10.0.1.0/24"
subnet_name = "chiru-pub-subnet"

az = "us-east-1a"

sg_name = "chiru-sg"

allowed_ip = [
  "0.0.0.0/0"
]

ami = "ami-002192a70217ac181"

instance_type = "t2.micro"


instance_name = "chiru-terraform-ec2"