output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu_ami.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}

output "allow_public_access_policy_json" {
  value = data.aws_iam_policy_document.allow_public_access.json
}
