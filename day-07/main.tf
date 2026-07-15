data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
resource "aws_db_subnet_group" "rds_subnet" {
  name       = var.db_subnet_group_name
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "rds-subnet-group"
  }
}
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow MySQL access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
resource "aws_db_instance" "mysql" {
  identifier             = var.db_identifier
  allocated_storage      = var.allocated_storage
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = var.engine_version
  instance_class         = var.instance_class

  db_name                = var.database_name
  username               = var.master_username
  password               = var.master_password

  publicly_accessible    = true
  skip_final_snapshot    = true

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "public-mysql-rds"
  }
}