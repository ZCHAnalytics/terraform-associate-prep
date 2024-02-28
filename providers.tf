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
  access_key = var.TF_VAR_AWS_ACCESS_KEY_ID
  secret_key = var.TF_VAR_AWS_SECRET_ACCESS_KEY

}

