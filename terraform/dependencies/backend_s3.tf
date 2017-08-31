resource "aws_s3_bucket" "sprinklr_terraform" {
  bucket = "sprinklr-test-terraform-states"
  acl    = "private"

  tags {
    Name        = "sprinklr-test-terraform-states"
    Environment = "production"
  }
}
