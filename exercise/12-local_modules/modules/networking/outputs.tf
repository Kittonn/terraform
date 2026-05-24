output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of the VPC."
}

output "public_subnets" {
  value = {
    for key in keys(local.public_subnets) : key => {
      subnet_id = aws_subnet.this[key].id
      az         = aws_subnet.this[key].availability_zone
    }
  }
}

output "private_subnets" {
  value = {
    for key in keys(local.private_subnets) : key => {
      subnet_id = aws_subnet.this[key].id
      az         = aws_subnet.this[key].availability_zone
    }
  }
}
