# tfvarsから取得
variable "allow_cidr_block" {}

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

module "sg" {
  source           = "../modules/network/sg"
  name_prefix      = local.name_prefix
  vpc_id           = module.vpc.vpc_id
  allow_cidr_block = var.allow_cidr_block
}

module "alb" {
  source          = "../modules/alb"
  subnet_az_1a_id = module.subnet.subnet_public_alb_1a_id
  subnet_az_1b_id = module.subnet.subnet_public_alb_1b_id
  sg_alb_id       = module.sg.sg_alb_id
  vpc_id          = module.vpc.vpc_id
}

module "ec2" {
  source      = "../modules/ec2"
  name_prefix = local.name_prefix
  sg_id       = module.sg.sg_ec2_id
  subnet_id   = module.subnet.subnet_private_ec2_1a_id
}