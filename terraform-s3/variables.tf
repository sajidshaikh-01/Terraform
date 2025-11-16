variable "aws_region" {
  description = "AWS region for the S3 bucket"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

variable "bucket_name" {
  description = "Unique name for the S3 bucket"
  type        = string
}

variable "env" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
  default     = "dev"
}
