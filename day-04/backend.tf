terraform {
  backend "s3" {
    bucket = "chiruuuuuuu"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}