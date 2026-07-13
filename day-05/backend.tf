terraform {
  backend "s3" {
    bucket = "chiru-terraform-buckt"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    
    #use_lockfile = true ##supports terrafrom latest version >=1.10
    dynamodb_table = "chiru-dynamodb"
    encrypt        = true
  }
}