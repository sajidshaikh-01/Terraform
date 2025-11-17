variable "region" {
  default = "us-east-1"
  type    = string
}

variable "project_name" {
  default = "my-terraform-project"
  type    = string
}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0ecb62995f68bb549"
  type        = string
}

variable "existing_key_name" {
  description = "Name of the existing key pair to use for the EC2 instance"
  default     = "my_amazon_key"
  type        = string

}
