output "bucket_name" {
value = aws_s3_bucket.mybucket.bucket
description = "S3 bucket name created by Terraform"
}
