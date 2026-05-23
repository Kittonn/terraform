resource "random_id" "bucket_suffix" {
  byte_length = 4
}


resource "aws_s3_bucket" "website_bucket" {
  bucket = "demo-s3-bucket-tf-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "disable_public_access" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "get_object_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = data.aws_iam_policy_document.allow_public_access.json
}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.website_bucket.arn}/*",
    ]
  }

  depends_on = [aws_s3_bucket_public_access_block.disable_public_access]
}

resource "aws_s3_bucket_website_configuration" "web" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "upload_html" {
  for_each     = fileset("${path.module}/website", "*.html")
  bucket       = aws_s3_bucket.website_bucket.id
  key          = each.value
  source       = "${path.module}/website/${each.value}"
  content_type = "text/html"
  etag         = filemd5("${path.module}/website/${each.value}")
}
