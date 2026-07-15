terraform {
  backend "s3" {
    bucket         = "chiruuuuu-bkt"
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}