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
  source                           = "../modules/network/subnet"
  name_prefix                      = local.name_prefix
  public_subnet_alb_1a_cidr_block  = local.public_subnet_alb_1a_cidr_block
  public_subnet_alb_1b_cidr_block  = local.public_subnet_alb_1b_cidr_block
  private_subnet_alb_1a_cidr_block = local.private_subnet_alb_1a_cidr_block
  vpc_id                           = module.vpc.vpc_id
  subnet_az_1a                     = local.subnet_az_1a
  subnet_az_1b                     = local.subnet_az_1b
}