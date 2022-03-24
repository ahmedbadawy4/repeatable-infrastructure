provider "aws" {
  region  = var.region
  profile = var.profile
}
terraform {
  required_version = "=1.0.5"
  backend "s3" {
    bucket = "terra-test-state-"
    key    = "demo-test-state"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "registry.terraform.io/hashicorp/aws"
      version = "=4.6.0"
    }
  }
}