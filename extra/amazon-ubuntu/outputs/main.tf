terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-01c0540df77ccaa68" # Replace with Ubuntu 16.04 arm64
  instance_type          = "t4g.micro"

  tags = {
    Name = var.instance_name
  }
}
