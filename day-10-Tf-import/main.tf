resource "aws_instance" "name" {
    ami ="ami-0fd6b4bfb40773c2d"
    instance_type="t2.micro"
    tags = {
        Name = "chiru"
    }
    subnet_id = "subnet-0374967feb083c6b9"
    vpc_security_group_ids = ["sg-05803eb317c83decc"]
}


resource "aws_s3_bucket" "mybucket" {
    bucket = "chiruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu-bkt"
  
}