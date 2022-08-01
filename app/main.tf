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

module "vpc" {
  source      = "../modules/network/vpc"
  name_prefix = local.name_prefix
  cidr_block  = local.cidr_block
}

module "subnet" {
  source                   = "../modules/network/subnet"
  name_prefix              = local.name_prefix
  public_subnet_cidr_block = local.public_subnet_cidr_block
  vpc_id                   = module.vpc.vpc_id
  subnet_az                = local.subnet_az
}