resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "demo-vpc"
    Project = "multiple-resources"
  }
}

resource "aws_subnet" "subnet" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.${count.index + 20}.0/24"

  tags = {
    Name    = "subnet-${count.index + 1}"
    Project = "multiple-resources"
  }
}

resource "aws_subnet" "subnet_from_map" {
  for_each   = var.subnet_config_map
  vpc_id     = aws_vpc.vpc.id
  cidr_block = each.value.cidr_block

  tags = {
    Name    = "subnet-${each.key}"
    Project = "multiple-resources"
  }
}
