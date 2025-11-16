output "user_name" {
  description = "IAM user name"
  value       = aws_iam_user.user.name
}

output "user_arn" {
  description = "IAM user ARN"
  value       = aws_iam_user.user.arn
}

output "policy_arn" {
  description = "Custom policy ARN"
  value       = aws_iam_policy.custom_policy.arn
}
