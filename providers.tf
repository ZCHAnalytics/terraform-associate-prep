terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = "default"
  access_key = terraform.workspace.var.aws_access_key
  secret_key = terraform.workspace.var.aws_secret_key
}
