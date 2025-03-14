terraform {
  backend "s3" {
    bucket = "twot-backend"
    key    = "twot/terraform.tfstate"  #path in s3 bucket
    region = "us-east-1"
    aws_dynamodb_table = "twot-lock"
  }
}

