output "allow_public_access_policy_json" {
  value = data.aws_iam_policy_document.allow_public_access.json
}
