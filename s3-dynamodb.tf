resource "aws_s3_bucket" "twot-backend" {
  bucket = "twot-backend"
}

resource "aws_dynamodb_table" "twot-lock" {
  name             = "twot-lock"
  hash_key         = "LockID"
  billing_mode     = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}