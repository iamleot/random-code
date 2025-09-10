provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    ec2 = "http://localhost:5000"
    iam = "http://localhost:5000"
    s3  = "http://s3.localhost.localstack.cloud:5000"
  }
}

module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.9.0"

  bucket = "testing-aws-s3"
  acl    = "private"

  versioning = {
    enabled = true
  }
}
