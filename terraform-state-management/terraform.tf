terraform {
  backend "s3" {
    bucket = "my-unique-remote-state-bucket-123456"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-unique-remote-state-lock-table-123456"
    
    
  }
}
