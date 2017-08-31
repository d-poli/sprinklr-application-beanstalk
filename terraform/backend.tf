resource "aws_s3_bucket" "sprinklr_terraform" {
  bucket = "sprinklr-test-terraform-states"
  acl    = "private"

  tags {
    Name        = "sprinklr-test-terraform-states"
    Environment = "production"
  }
}

terraform {
  backend "s3" {
    bucket = "sprinklr-test-terraform-states"
    key    = "teste-nodejs/production/tf-state"
    region = "us-east-1"
  }
}
