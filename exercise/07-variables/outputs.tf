output "s3_bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "Name of the S3 bucket created in this project"
}

output "sensitive_output_example" {
  value       = var.my_sensitive_variable
  description = "This output is marked as sensitive and will not be displayed in the CLI output"
  sensitive   = true
}
