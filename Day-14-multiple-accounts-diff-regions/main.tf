resource "aws_s3_bucket" "dev_bucket" {
  bucket = "chirasmita-dev-bucket"
}

resource "aws_s3_bucket" "test_bucket" {
  bucket   = "chirasmita-test-bucket"
  provider = aws.test-account
}