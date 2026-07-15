terraform {
  backend "s3" {
    bucket         = "sfdghjkljhgfbghj-bkt"
    key            = "day-07-rds/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}