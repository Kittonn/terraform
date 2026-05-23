data "aws_iam_policy_document" "allow_public_access" {
  statement {
    sid = "AllowPublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::*/*"
    ]
  }
}
