terraform {
  backend "s3" {
    bucket = "twot-backend"
    key    = "twot/terraform.tfstate"  #path in s3 bucket
    region = "us-east-1"
  }
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