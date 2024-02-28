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
  access_key = terraform.workspace.variables["aws_access_key_id"]
  secret_key = terraform.workspace.variables["aws_secret_access_key"]
}
