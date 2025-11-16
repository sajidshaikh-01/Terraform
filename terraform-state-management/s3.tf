resource "aws_s3_bucket" "remote_s3" {
    bucket = "my-unique-remote-state-bucket-123456"
    
    tags = { 
    
        Name        = "my-unique-remote-state-bucket-123456"
    }
  
}
