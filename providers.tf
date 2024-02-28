terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
}

resource "aws_s3_bucket" "zch-terraform-bucket" {
  bucket  = "my-tf-bucket"
}
