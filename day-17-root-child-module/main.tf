module "network" {
  source = "./module/networking"
  vpc_cidr      = var.vpc_cidr
  public_subnet1  = var.public_subnet1
  public_subnet2  = var.public_subnet2
  private_subnet1 = var.private_subnet1
  private_subnet2 = var.private_subnet2
 az1 = var.az1   
 az2 = var.az2
}
module "ec2" {
  source = "./module/ec2"
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = module.network.public_subnet1_id
  security_group = module.network.web_sg
}
module "rds" {
  source = "./module/rds"
 
  subnet1 = module.network.private_subnet1_id
  subnet2= module.network.private_subnet2_id
  security_group = module.network.db_sg
}