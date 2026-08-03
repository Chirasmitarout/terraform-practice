resource "aws_db_subnet_group" "db" {

  subnet_ids = [
    var.subnet1,
    var.subnet2
  ]
}

resource "aws_db_instance" "mysql" {

  allocated_storage = 20

  engine = "mysql"

  instance_class = "db.t3.micro"

  username = "admin"

  password = "Admin123"

  skip_final_snapshot = true

  db_subnet_group_name = aws_db_subnet_group.db.name

  vpc_security_group_ids = [
    var.security_group
  ]
}