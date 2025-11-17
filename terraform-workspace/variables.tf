variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use for EC2"
  type        = string
  default     = "ami-0c02fb55956c7d316"   # Amazon Linux 2 (us-east-1)
}

variable "instance_type" {
  description = "Instance type per workspace"
  type        = map(string)

  # Different instance types for each workspace
  default = {
    default = "t2.micro"
    dev     = "t2.micro"
    stage   = "t3.micro"
    prod    = "t3.medium"
  }
}
