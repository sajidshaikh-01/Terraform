terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }
}
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# -------------------------
# 1. Create an S3 Bucket
# -------------------------
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name # dynamic name from variable

  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }
}

# -------------------------
# 2. Enable Versioning
# -------------------------
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# -------------------------
# 3. Enable Server-Side Encryption
# -------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# -------------------------
# 4. Public Access Block (Security Best Practice)
# -------------------------
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
