locals {
  private_subnet_cidrs = ["10.0.0.0/24"]
  public_subnet_cidrs  = ["10.0.128.0/24"]
  vpc_cidr             = "10.0.0.0/16"
}

data "aws_availability_zones" "available_azs" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.project_name
  cidr = local.vpc_cidr

  azs = data.aws_availability_zones.available_azs.names

  private_subnets = local.private_subnet_cidrs
  public_subnets  = local.public_subnet_cidrs

  tags = local.common_tags
}
