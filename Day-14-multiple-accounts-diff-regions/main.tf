resource "aws_s3_bucket" "dev_bucket" {
  bucket   = "chhhhh..."
  provider = aws.dev-account
}

resource "aws_s3_bucket" "test_bucket" {
  bucket   = "chhhhh..."
  provider = aws.test-account
}