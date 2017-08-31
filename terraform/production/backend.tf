terraform {
  backend "s3" {
    bucket = "sprinklr-test-terraform-states"
    key    = "teste-nodejs/production/tf-state"
    region = "us-east-1"
  }
}
