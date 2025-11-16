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

# -------------------------------
# 1. Create IAM User
# -------------------------------
resource "aws_iam_user" "user" {
  name = var.user_name
  tags = {
    Environment = var.env
  }
}

# -------------------------------
# 2. Create Custom IAM Policy
# -------------------------------
resource "aws_iam_policy" "custom_policy" {
  name        = var.policy_name
  description = "Custom policy that allows read-only access to S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:GetObject"
        ]
        Resource = "*"
      }
    ]
  })
}

# -------------------------------
# 3. Attach Policy to User
# -------------------------------
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.custom_policy.arn
}
