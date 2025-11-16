resource "aws_dynamodb_table" "basic_dynamodb-table" {
    name         = "my-unique-remote-state-lock-table-123456"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    
    attribute {
        name = "LockID"
        type = "S"
    }
    
    tags = {
        Name = "my-unique-remote-state-lock-table-123456"
    }
  
}
