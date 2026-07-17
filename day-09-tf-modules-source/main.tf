module "dev" {
    source ="../day-9-Modules-ec2"
    ami_id = "ami-002192a70217ac181"
    instance_type = t2.micro
    tags = "dev-instance"
  
}

