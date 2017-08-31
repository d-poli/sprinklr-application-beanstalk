
provider "aws" {
  region     = "sa-east-1"
}

resource "aws_s3_bucket" "sprinklr_terraform" {
  bucket = "sprinklr-test-terraform-states"
  acl    = "private"

  lifecycle {
        ignore_changes = ["bucket"]
  }

  tags {
    Name        = "sprinklr-test-terraform-states"
    Environment = "production"
  }
}
