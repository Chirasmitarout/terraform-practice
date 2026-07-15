region = "us-west-2"

db_identifier = "my-public-rds"

database_name = "mydatabase"

master_username = "admin"

master_password = "Cloud12345"

allocated_storage = 20

engine_version = "8.0"

instance_class = "db.t3.micro"

db_subnet_group_name = "my-rds-subnet-group"

allowed_cidr_blocks = [
  "0.0.0.0/0"
]