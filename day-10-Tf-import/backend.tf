terraform {
  backend "s3" {
    bucket = "cchhiirruu-tf-bkt"
    key    = "terraform.tfstate"
    region = "us-west-2"
    use_lockfile = true ##supports terrafrom latest version >=1.10
    #dynamodb_table = "terraform-state-locking"  #if terrafrom version <1.10 use below code
    
  }
}