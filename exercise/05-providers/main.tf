resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_sg" {
  bucket = "demo-s3-bucket-terraform-sg-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket" "s3_syd" {
  provider = aws.sydney
  bucket   = "demo-s3-bucket-terraform-syd-${random_id.bucket_suffix.hex}"
}
