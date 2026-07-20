


data "aws_subnet" "existing" {
  id = "subnet-096879542457ec720"
}

resource "aws_instance" "web" {
  ami           = "ami-04d78408ebc2960db"
  instance_type = "t2.medium"
  subnet_id     = data.aws_subnet.existing.id
  lifecycle {
    #create_before_destroy = true
    prevent_destroy = true 
        ignore_changes = [
      tags
    ]

  
  }

  tags = {
    Name = "WebServer"
  }
}
