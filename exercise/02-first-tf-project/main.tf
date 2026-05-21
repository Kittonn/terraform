resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_example" {
  bucket = "demo-s3-bucket-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "Demo S3 Bucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.s3_example.bucket
}
