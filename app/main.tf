provider "aws" {
  region = "us-west-1"

  default_tags {
    tags = {
      System = local.name_prefix
      Owner  = "lightkun"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.9.0"
    }
  }

  required_version = "1.2.6"

  backend "s3" {
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.5.0.0/16"
}