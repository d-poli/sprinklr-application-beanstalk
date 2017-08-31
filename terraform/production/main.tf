/* General Parameters */

provider "aws" {
  region     = "sa-east-1"
}

variable "aws_region" {
  type    = "string"
  default = "sa-east-1"
}

variable "stack_name" {
  type    = "string"
  default = "nodejs-application"
}

variable "stack_env" {
  type    = "string"
  default = "production"
}


/* VPC Parameters */

variable "vpc_cidr" {
  type    = "string"
  default = "10.42.0.0/16"
}

variable "private_subnet_a_cidr" {
  type    = "string"
  default = "10.42.3.0/24"
}


variable "private_subnet_b_cidr" {
  type    = "string"
  default = "10.42.4.0/24"
}


variable "private_subnet_c_cidr" {
  type    = "string"
  default = "10.42.5.0/24"
}

variable "public_subnet_a_cidr" {
  type    = "string"
  default = "10.42.0.0/24"
}

variable "public_subnet_b_cidr" {
  type    = "string"
  default = "10.42.1.0/24"
}

variable "public_subnet_c_cidr" {
  type    = "string"
  default = "10.42.2.0/24"
}

/* SSL Certificate Parameters */

variable "certificate_arn" {
  type    = "string"
  default = "arn:aws:acm:us-west-2:232667596449:certificate/eaf09cbc-5bab-4fae-acac-3619a5091325"
}


/* DNS Zone */

data "aws_route53_zone" "nodejs_public_zone" {
  name = "domain.com.br"
  private_zone = false
}


