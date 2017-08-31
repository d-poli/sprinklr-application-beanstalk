terraform {
  backend "s3" {
    bucket = "sprinklr-test-terraform-states"
    key    = "teste-nodejs/production/tf-state"
    region = "sa-east-1"
  }
}
