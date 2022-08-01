locals {
  name_prefix                      = "alb-maintenance-infra-lightkun"
  cidr_block                       = "10.5.0.0/16"
  public_subnet_alb_1a_cidr_block  = "10.5.1.0/24"
  public_subnet_alb_1b_cidr_block  = "10.5.2.0/24"
  private_subnet_alb_1a_cidr_block = "10.5.4.0/24"
  subnet_az_1a                     = "us-west-1a"
  subnet_az_1b                     = "us-west-1b"
}