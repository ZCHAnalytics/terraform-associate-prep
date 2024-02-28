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

resource "aws_s3_bucket" "s3" {
  bucket  = "my-tf-bucket"
}
