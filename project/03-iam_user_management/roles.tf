locals {
  role_policies = {
    readonly = [
      "ReadOnlyAccess"
    ],
    developer = [
      "PowerUserAccess"
    ],
    admin = [
      "AdministratorAccess"
    ],
    auditor = [
      "SecurityAudit"
    ]
  }

  role_policies_list = flatten([
    for role, policies in local.role_policies : [
      for policy in policies : {
        role   = role
        policy = policy
      }
    ]
  ])
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_policy_document" {
  for_each = toset(keys(local.role_policies))

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        for username in keys(aws_iam_user.iam_user) :
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${username}"
        if contains(local.user_map[username], each.key)
      ]
    }
  }
}

resource "aws_iam_role" "aws_role" {
  for_each = toset(keys(local.role_policies))
  name     = each.value

  assume_role_policy = data.aws_iam_policy_document.iam_policy_document[each.value].json
}

data "aws_iam_policy" "managed_policies" {
  for_each = toset(local.role_policies_list[*].policy)
  arn      = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_role_policy_attachment" "role_attachments" {
  count      = length(local.role_policies_list)
  role       = aws_iam_role.aws_role[local.role_policies_list[count.index].role].name
  policy_arn = data.aws_iam_policy.managed_policies[local.role_policies_list[count.index].policy].arn
}
