provider "aws" {  
    
}
provider "aws" {
    profile = "test"
    alias = "test-account"
    region = "us-west-2"
  
}