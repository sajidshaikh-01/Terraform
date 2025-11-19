resource "aws_s3_bucket" "logs" {
  bucket = "prod-app-logs"

  lifecycle {
    prevent_destroy = true
  }
}
