variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile name"
  type        = string
  default     = "default"
}

variable "user_name" {
  description = "IAM username to create"
  type        = string
}

variable "policy_name" {
  description = "Custom policy name"
  type        = string
}

variable "env" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}
