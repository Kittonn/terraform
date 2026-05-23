data "aws_vpc" "prod_vpc" {
  tags = {
    Environment = "prod"
  }
}


