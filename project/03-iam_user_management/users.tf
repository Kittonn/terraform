locals {
  user_from_yaml = yamldecode(file("${path.module}/users.yaml")).users
  user_map = {
    for user in local.user_from_yaml : user.username => user.roles
  }
}

resource "aws_iam_user" "iam_user" {
  for_each = toset(keys(local.user_map))
  name     = each.value
}

resource "aws_iam_user_login_profile" "iam_user_login" {
  for_each        = aws_iam_user.iam_user
  user            = each.value.name
  password_length = 8

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }
}

output "user_password" {
  sensitive = true
  value = {
    for user, login in aws_iam_user_login_profile.iam_user_login :
    user => login.password
  }
}
