# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "terraform-vpc"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "terraform-igw"
  }
}

# -------------------------
# Public Subnet 1
# -------------------------
resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet1
  availability_zone       = var.az1
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet2
  availability_zone       = var.az2
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-2"
  }
}

# -------------------------
# Route Table
# -------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block="0.0.0.0/0"
    gateway_id=aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}

# -------------------------
# DB Subnet Group
# -------------------------
resource "aws_db_subnet_group" "rds" {
  name = "rds-subnet-group"

  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

# -------------------------
# Redis Subnet Group
# -------------------------
resource "aws_elasticache_subnet_group" "redis" {
  name = "redis-subnet-group"

  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "database" {
  name   = "database-sg"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port=3306
    to_port=3306
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  ingress {
    from_port=6379
    to_port=6379
    protocol="tcp"
    cidr_blocks=["0.0.0.0/0"]
  }

  egress {
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
  }
}

# -------------------------
# Public RDS
# -------------------------
resource "aws_db_instance" "mysql" {

  identifier = var.db_identifier

  engine               = "mysql"
  engine_version       = "8.0"

  instance_class       = "db.t3.micro"

  allocated_storage    = 20
  storage_type         = "gp2"

  db_name              = var.database_name
  username             = var.db_username
  password             = var.db_password

  publicly_accessible  = true

  backup_retention_period = 7
  backup_window           = "03:00-04:00"

  skip_final_snapshot  = true
  deletion_protection  = false

  db_subnet_group_name = aws_db_subnet_group.rds.name

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  apply_immediately = true

  tags = {
    Name = "terraform-primary-rds"
  }
}
# -------------------------
# Elastic Cache Redis
# -------------------------
resource "aws_elasticache_cluster" "redis" {

  cluster_id = "terraform-redis"

  engine = "redis"

  node_type = "cache.t3.micro"

  num_cache_nodes = 1

  port = 6379

  subnet_group_name = aws_elasticache_subnet_group.redis.name

  security_group_ids = [
    aws_security_group.database.id
  ]
}

resource "aws_db_instance" "mysql_read_replica" {

  identifier = var.read_replica_identifier

  replicate_source_db = aws_db_instance.mysql.identifier

  instance_class = "db.t3.micro"

  publicly_accessible = true

  apply_immediately = true

  skip_final_snapshot = true

  vpc_security_group_ids = [
    aws_security_group.database.id
  ]

  depends_on = [
    aws_db_instance.mysql
  ]

  tags = {
    Name = "terraform-read-replica"
  }
}